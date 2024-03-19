//
//  ExperienceView.swift
//  JobSearch
//
//  Created by user on 15.03.2024.
//

import UIKit

class ExperienceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "experience")
        return imageView
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Опыт от 1 года до 3 лет"
        return label
    }()
    
    private func setSubiews() {
        addSubview(icon)
        addSubview(experienceLabel)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalTo: leftAnchor),
            icon.centerYAnchor.constraint(equalTo: experienceLabel.centerYAnchor),
            icon.rightAnchor.constraint(equalTo: experienceLabel.leftAnchor, constant: 8),
            
            experienceLabel.topAnchor.constraint(equalTo: topAnchor),
            experienceLabel.rightAnchor.constraint(equalTo: rightAnchor),
            experienceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
