//
//  ExperienceAndSchedulesView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class ExperienceAndSchedulesView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Требуемый опыт:"
        return label
    }()
    
    private let schedulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Полная занятость, полный день"
        return label
    }()
    
    private func setSubiews() {
        addSubview(experienceLabel)
        addSubview(schedulesLabel)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            experienceLabel.topAnchor.constraint(equalTo: topAnchor),
            experienceLabel.leftAnchor.constraint(equalTo: leftAnchor),
            experienceLabel.rightAnchor.constraint(equalTo: rightAnchor),

            schedulesLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 6),
            schedulesLabel.leftAnchor.constraint(equalTo: leftAnchor),
            schedulesLabel.rightAnchor.constraint(equalTo: rightAnchor),
            schedulesLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
