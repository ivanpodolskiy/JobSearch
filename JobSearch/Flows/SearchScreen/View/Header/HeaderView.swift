//
//  FavoriteViewController.swift
//  JobSearch
//
//  Created by user on 16.03.2024.
//

import UIKit

class HeaderView: UIView {
    private var adapter: RecommendationsCollectionViewAdapter?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAdapter(_ adapter:RecommendationsCollectionViewAdapter ) {
        self.adapter = adapter
        collectionView.dataSource = self.adapter
    }
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 132, height: 120)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecommendationsCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationsCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let filterButtom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .specialGrey2
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor  = .white
        searchBar.searchTextField.backgroundColor = .specialGrey2
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Должность, ключевые слова", attributes: [NSAttributedString.Key.foregroundColor: UIColor.specialGrey3])
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        searchBar.isUserInteractionEnabled = false
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private func setSubiews() {
        addSubview(searchBar)
        addSubview(filterButtom)
        addSubview(collectionView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            filterButtom.topAnchor.constraint(equalTo: topAnchor),
            filterButtom.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            filterButtom.widthAnchor.constraint(equalToConstant: 40),
            filterButtom.heightAnchor.constraint(equalToConstant: 40),

            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            searchBar.rightAnchor.constraint(equalTo: filterButtom.leftAnchor, constant: -7),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 34),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
