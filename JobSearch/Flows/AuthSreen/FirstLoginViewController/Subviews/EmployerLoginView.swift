//
//  EmployerLoginView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit

class EmployerLoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayerAndColor()
        setSubviews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayerAndColor() {
        layer.cornerRadius = 8
        backgroundColor = .specialGrey
    }
    private let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Поиск сотрудников"
        return label
    }()
    private let descriptionLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.text = "Размещение вакансий и доступ к базе резюме"
        return label
    }()
    private let findEmployeeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .specialGreen
        button.setTitle("Я ищу сотрудников", for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private func setSubviews() {
        addSubview(titleLable)
        addSubview(descriptionLable)
        addSubview(findEmployeeButton)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            descriptionLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8),
            descriptionLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            findEmployeeButton.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            findEmployeeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            findEmployeeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            findEmployeeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
    }
}
