//
//  QuestionsListView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit

class QuestionsListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubiews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let upperDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Задайте вопрос работодателю"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    private let lowerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Он получит его с откликом на вакансию"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    private func getButton(title: String) -> UIButton{
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .specialGrey2
        button.layer.cornerRadius = 16
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.white]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    func addQuestionsButton(from guestions: [String]) {
        guestions.forEach { guestion in
            let button = getButton(title: guestion)
            stackView.addArrangedSubview(button)
        }
        layoutIfNeeded()
    }
    private func setSubiews() {
        addSubview(upperDescriptionLabel)
        addSubview(lowerDescriptionLabel)
        addSubview(stackView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            upperDescriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            upperDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            upperDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            lowerDescriptionLabel.topAnchor.constraint(equalTo: upperDescriptionLabel.bottomAnchor, constant: 8),
            lowerDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            lowerDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            stackView.topAnchor.constraint(equalTo: lowerDescriptionLabel.bottomAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
