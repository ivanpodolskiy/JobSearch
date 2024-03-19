//
//  VacancyCollectionViewCell.swift
//  JobSearch
//
//  Created by user on 14.03.2024.
//

import UIKit


class VacancyCollectionViewCell: UICollectionViewCell {
    struct Constant {
        static let indentation: CGFloat = 16
        static let spacing: CGFloat = 10
    }
    private var viewWidth: CGFloat = 0
  

    override func prepareForReuse() {
        super.prepareForReuse()
        salaryLabel.removeFromSuperview()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setSubviews()
        self.activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constant.spacing
        return stackView
    }()
    private let numberOfviewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .specialGreen
        label.text = "Сейчас просматривает 1 человек"
        return label
    }()
    private let postTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "UI/UX Designer"
        return label
    }()
    
    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "1500-2900 Br"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let cityAndCompanyView: UIView = {
        let view = CityAndCompanyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let publicationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Опубликовано 16 февраля"
        label.textColor = UIColor.gray
        return label
    }()
    private let experienceView: UIView = {
        let view = ExperienceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite"), for: .normal)
        button.setImage(UIImage(named: "favorite.fill"), for: .selected)
        return button
    }()
    
    private let respondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Откликнуться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.specialGreen
        
        button.layer.cornerRadius = 14
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        
        return button
    }()
    
    private func setSubviews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(numberOfviewsLabel)
        stackView.addArrangedSubview(postTitle)
        stackView.addArrangedSubview(cityAndCompanyView)
        stackView.addArrangedSubview(publicationDateLabel)
        
        containerView.addSubview(favoriteButton)
        containerView.addSubview(respondButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewWidth = superview?.frame.width ?? containerView.frame.width
        activateLayout()
    }
    
    private func activateLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: viewWidth - (Constant.indentation * 2)),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.indentation),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constant.indentation),
            stackView.bottomAnchor.constraint(equalTo: publicationDateLabel.bottomAnchor, constant: -Constant.indentation),
            
            favoriteButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.indentation),
            favoriteButton.leftAnchor.constraint(equalTo: stackView.rightAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constant.indentation),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            
            respondButton.topAnchor.constraint(equalTo: publicationDateLabel.bottomAnchor, constant: 20),
            respondButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constant.indentation),
            respondButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constant.indentation),
            respondButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constant.indentation),
        ])
    }
}
extension VacancyCollectionViewCell {
    func setSalaryLabel() {
        stackView.insertArrangedSubview(salaryLabel, at: 2)
    }
}

extension VacancyCollectionViewCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}
