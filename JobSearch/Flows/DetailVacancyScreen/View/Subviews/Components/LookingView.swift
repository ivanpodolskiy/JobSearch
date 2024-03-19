//
//  LookingView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class LookingView: UIView {
    init(descroption: String, icon: UIImage) {
        super.init(frame: .zero)
        lookingInfoLabel.text  = descroption
        iconImage.image = icon.withTintColor(.white, renderingMode: .alwaysOriginal)
        setSubviews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .specialDarkGreen
        return view
    }()
    private let lookingInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    private let iconImage:  UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .specialGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private func setSubviews() {
        addSubview(containerView)
        containerView.addSubview(iconImage)
        containerView.addSubview(lookingInfoLabel)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lookingInfoLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            lookingInfoLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            lookingInfoLabel.rightAnchor.constraint(equalTo: iconImage.leftAnchor, constant: -21),
            lookingInfoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            iconImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            iconImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            iconImage.widthAnchor.constraint(equalToConstant: 16),
            iconImage.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}
