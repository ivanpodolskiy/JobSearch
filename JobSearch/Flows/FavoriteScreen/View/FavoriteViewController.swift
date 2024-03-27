//
//  FavoriteViewController.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit
import Combine

class FavoriteViewController: UIViewController  {
    private var viewModel: FavoriteViewModel?
    private var cencellables =  Set<AnyCancellable>()

    private var favoriteItems: [VacancyItem] = []
    
    func setViewModel(_ viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setSubiews()
        activateLayout()
        
        viewModel?.$favoriteVacancies
            .sink { [weak self] favoriteItems in
                guard let self = self else { return }
                self.favoriteItems = favoriteItems
                self.reloadCollectionViewWithAnimation()
            }
            .store(in: &cencellables)
    }
    
    
    private func reloadCollectionViewWithAnimation() {
        DispatchQueue.main.async {
            UIView.transition(with: self.collectionView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { self.collectionView.reloadData() })
        }
    }
    private lazy var collectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 20, right: 0)
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 200)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(VacancyCollectionViewCell.self, forCellWithReuseIdentifier: VacancyCollectionViewCell.identifier)
        collectionView.register(FavoriteHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: FavoriteHeader.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private func setSubiews() {
        view.addSubview(collectionView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VacancyCollectionViewCell.identifier, for: indexPath) as! VacancyCollectionViewCell
        let item = favoriteItems[indexPath.row]
        let itemForCell = VacanciyCell(from: item)
        
        cell.configure(vacanciyCell: itemForCell) { [weak self] _ in
            guard let self = self else { return }
            viewModel?.removeFromFavorite(id: item.id)
        }
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVacancyViewController()
        let item = favoriteItems[indexPath.row]
        detailVC.loadData(item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavoriteHeader.identifier, for: indexPath) as! FavoriteHeader
        reusableview.setText(getVacanciesString(favoriteItems.count))
        
        return reusableview
    }
    
    func getVacanciesString(_ count: Int) -> String {
        let word = "ваканси"
        var suffix = ""
        if count % 10 == 1 && count % 100 != 11 {
            suffix = "я"
        } else if count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) {
            suffix = "и"
        }
        
        return "\(count) \(word)\(suffix)"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width:  collectionView.frame.width, height: 65)
    }
}
