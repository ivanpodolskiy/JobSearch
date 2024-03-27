//
//  VacancyInfoView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class VacancyInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadData(vacancyDetail: VacancyDetail) {
        titleLabel.text = vacancyDetail.title
        salaryLabel.text = vacancyDetail.salary ?? "Уровень дохода не указан"
        experienceAndSchedulesView.setData(experience: vacancyDetail.experience, schedules: vacancyDetail.schedules)
        layoutIfNeeded()
    }
    private let experienceAndSchedulesView = ExperienceAndSchedulesView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activateLayout()
    }
    private func setSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(salaryLabel)
        stackView.addArrangedSubview(experienceAndSchedulesView)
    }
    private func activateLayout() {
        experienceAndSchedulesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
