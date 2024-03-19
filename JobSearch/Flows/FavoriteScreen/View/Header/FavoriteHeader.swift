//
//  FavoriteHeader.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit

class FavoriteHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "Избранное"
        return label
    }()
    
    private let numberVacancyLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "6 вакансия"
        label.textColor = .gray
        return label
    }()
    
    private func setSubviews() {
        addSubview(titleLabel)
        addSubview(numberVacancyLablel)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

            numberVacancyLablel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            numberVacancyLablel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            numberVacancyLablel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            numberVacancyLablel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension FavoriteHeader: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
