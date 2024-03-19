//
//  CityAndCompanyView.swift
//  JobSearch
//
//  Created by user on 15.03.2024.
//

import UIKit

class CityAndCompanyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Минск"
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Мобирикс"
        return label
    }()
    
    private let verificationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "verification")
        return imageView
    }()
    
    private func setSubviews() {
        addSubview(cityLabel)
        addSubview(companyLabel)
        addSubview(verificationIcon)
    }
    
    private func activateLayout() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 2),
            companyLabel.leftAnchor.constraint(equalTo: leftAnchor),
            companyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            verificationIcon.centerYAnchor.constraint(equalTo: companyLabel.centerYAnchor),
            verificationIcon.leftAnchor.constraint(equalTo: companyLabel.rightAnchor, constant: 8),
            verificationIcon.heightAnchor.constraint(equalToConstant: 16),
            verificationIcon.widthAnchor.constraint(equalToConstant: 16),
        ])
    }
}
