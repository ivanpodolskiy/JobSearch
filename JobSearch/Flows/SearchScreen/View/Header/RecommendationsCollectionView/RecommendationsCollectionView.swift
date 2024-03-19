//
//  RecommendationsCollectionView.swift
//  JobSearch
//
//  Created by user on 16.03.2024.
//

import UIKit

class RecommendationsCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    private var items: [Recommendation] = []
    func setRecommendationItems(_ items:  [Recommendation]) {
        self.items = items
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print ("items", items.count)
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.identifier, for: indexPath) as!  RecommendationsCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

class RecommendationsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = ""
        icon.image = nil
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = .specialGrey
        return view
    }()
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private func setSubiews() {
        addSubview(containerView)
        containerView.addSubview(icon)
        containerView.addSubview(textLabel)
    }
    
    private func activateLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            icon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            icon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            icon.widthAnchor.constraint(equalToConstant: 32),
            icon.heightAnchor.constraint(equalToConstant: 32),
            
            textLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16),
            textLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            textLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10)
        ])
    }
    func configure(with item: Recommendation) {
        textLabel.text = item.title
        icon.image = UIImage(systemName: "person")
    }
}

extension RecommendationsCollectionViewCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
    
    
}

