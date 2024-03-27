//
//  RecommendationsCollectionView.swift
//  JobSearch
//
//  Created by user on 16.03.2024.
//

import UIKit

class RecommendationsCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    private let imageNameList = ["location", "starGreen", "partTime", "adviсe"]
    private var items: [RecommendationCell] = []
    
    func setRecommendationItems(_ items:  [Recommendation]) {
        self.items = items.map { RecommendationCell(from: $0)}
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.identifier, for: indexPath) as!  RecommendationsCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(with: item, imageName:  imageNameList[indexPath.row])
        return cell
    }
}

