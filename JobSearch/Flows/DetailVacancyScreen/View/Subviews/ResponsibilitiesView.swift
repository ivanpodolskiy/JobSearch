//
//  ResponsibilitiesView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class ResponsibilitiesView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private  let responsibilitiesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "Ваши задачи"
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "-Проектировать пользовательский опыт, проводить UX исследования; -Разрабатывать адаптивный дизайн интерфейса для мобильных приложений; -Разрабатывать быстрые прототипы для тестирования идеи дизайна и их последующая; интеграция на основе обратной связи от команды и пользователей; -Взаимодействовать с командой разработчиков для обеспечения точной реализации ваших дизайнов; -Анализ пользовательского опыта и адаптация под тренды."
        return label
    }()
    private func setSubiews() {
        addSubview(descriptionLabel)
        addSubview(responsibilitiesTitle)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            responsibilitiesTitle.topAnchor.constraint(equalTo: topAnchor),
            responsibilitiesTitle.leftAnchor.constraint(equalTo: leftAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: responsibilitiesTitle.bottomAnchor, constant: 13),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
