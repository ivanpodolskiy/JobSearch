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
    
    func setText(_ text: String) {
        experienceLabel.text = text
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
        label.textColor = .white
        return label
    }()
    
    private func setSubiews() {
        addSubview(icon)
        addSubview(experienceLabel)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: experienceLabel.centerYAnchor),
            icon.leftAnchor.constraint(equalTo: leftAnchor),
            icon.heightAnchor.constraint(equalToConstant: 16),
            icon.widthAnchor.constraint(equalToConstant: 16),
            
            experienceLabel.topAnchor.constraint(equalTo: topAnchor),
            experienceLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            experienceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            experienceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
