//
//  SearchViewController.swift
//  JobSearch
//
//  Created by user on 14.03.2024.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewModel?
    
    private var vacancyItems: [VacancyItem] = []
    private let headerAdapter = RecommendationsCollectionViewAdapter()
    private var cencellable = Set<AnyCancellable>()
    
    func setViewModel(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupSubviews()
        
        viewModel?.$vacancies
            .sink { [weak self] vacancyItems in
                guard let self = self, vacancyItems.count != 0 else {return }
                self.vacancyItems = vacancyItems
                reloadCollectionViewWithAnimation()
            }
            .store(in: &cencellable)
        
        viewModel?.$recommendations
            .sink { [weak self] recommendations in
                guard let self = self else {return }
                headerAdapter.setRecommendationItems(recommendations)
                headerView.reloadCollection()
            }
            .store(in: &cencellable)
    }
    
    private func reloadCollectionViewWithAnimation() {
        DispatchQueue.main.async {
            UIView.transition(with: self.vacancyCollectionView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { self.vacancyCollectionView.reloadData() })
        }
    }
    
    private lazy var headerView: HeaderView  = {
        let headerView = HeaderView()
        headerView.setAdapter(headerAdapter)
        headerView.backgroundColor = .black
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var vacancyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 200)
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(VacancyCollectionViewCell.self, forCellWithReuseIdentifier: VacancyCollectionViewCell.identifier)
        collectionView.register(VacancyReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: VacancyReusableView.identifier)
        collectionView.register(ShowMoreReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ShowMoreReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()
    
    private func setupSubviews() {
        view.addSubview(vacancyCollectionView)
        NSLayoutConstraint.activate([
            vacancyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vacancyCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            vacancyCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            vacancyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(vacancyItems.count, 3)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VacancyCollectionViewCell.identifier, for: indexPath) as! VacancyCollectionViewCell
        let vacanciy = vacancyItems[indexPath.row]
        cell.configure(vacanciyCell: VacanciyCell(from: vacanciy)) { [weak self] bool in
            guard let self = self else { return  }
            self.viewModel?.changeFavoriteStatus(id: vacanciy.id, isFavorite: bool)
        }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VacancyReusableView.identifier, for: indexPath) as! VacancyReusableView
            reusableview.addSubviewAndActivateLayout(view: headerView)
            return reusableview
        case UICollectionView.elementKindSectionFooter:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ShowMoreReusableView.identifier, for: indexPath) as! ShowMoreReusableView
            reusableview.setText(vacancyCount: vacancyItems.count - min(vacancyItems.count, 3))
            return reusableview
        default : return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 234)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVacancyViewController()
        detailVC.loadData(vacancyItems[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
