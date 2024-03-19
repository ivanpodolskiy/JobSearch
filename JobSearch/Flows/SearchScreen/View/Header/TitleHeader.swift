//
//  VacancyReusableView.swift
//  JobSearch
//
//  Created by user on 16.03.2024.
//

import UIKit

class VacancyReusableView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вакансии для вас"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    func addSubviewAndActivateLayout(view: UIView) {
        addSubview(titleLabel)
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension VacancyReusableView: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
