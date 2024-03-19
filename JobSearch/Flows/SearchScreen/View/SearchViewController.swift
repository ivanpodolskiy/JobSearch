//
//  SearchViewController.swift
//  JobSearch
//
//  Created by user on 14.03.2024.
//

import UIKit

class SearchViewController: UIViewController {
    private let headerAdapter = RecommendationsCollectionViewAdapter()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setSubviews()
        activateLayout()
        vacancyCollectionView.reloadData()
    }
    
    private lazy var headerView: UIView  = {
        let headerView = HeaderView()
        headerView.setAdapter(self.headerAdapter)
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
        collectionView.register(VacancyReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: VacancyReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private func setSubviews() {
        view.addSubview(vacancyCollectionView)
    }
    private func activateLayout() {
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
            return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VacancyCollectionViewCell.identifier, for: indexPath) as! VacancyCollectionViewCell
        if indexPath.row  == 0 { cell.setSalaryLabel() }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VacancyReusableView.identifier, for: indexPath) as! VacancyReusableView
        reusableview.addSubviewAndActivateLayout(view: headerView)
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 234)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVacancyViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
