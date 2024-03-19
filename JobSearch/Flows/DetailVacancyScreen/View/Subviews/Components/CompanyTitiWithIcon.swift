//
//  CompanyTitiWithIcon.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class CompanyTitiWithIcon: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setSubviews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let companyTitle: UILabel = {
        let label = UILabel()
        label.text = "Мобирикс"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    private let verificationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "verification")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setSubviews() {
        addSubview(companyTitle)
        addSubview(verificationIcon)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            companyTitle.topAnchor.constraint(equalTo: topAnchor),
            companyTitle.leftAnchor.constraint(equalTo: leftAnchor),
            companyTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            verificationIcon.centerYAnchor.constraint(equalTo: companyTitle.centerYAnchor),
            verificationIcon.leftAnchor.constraint(equalTo: companyTitle.rightAnchor, constant: 8),
            verificationIcon.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: 8),
            verificationIcon.widthAnchor.constraint(equalToConstant: 16),
            verificationIcon.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}
