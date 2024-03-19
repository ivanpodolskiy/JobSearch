//
//  DetailVacancyViewController.swift
//  JobSearch
//
//  Created by user on 16.03.2024.
//

import UIKit

class DetailVacancyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .black
        setupNavigationBar()
        setSubviews()
        activateLayout()
    }
    
    private func setupNavigationBar() {
        let eyeButton = UIButton(type: .custom)
        let eyeImage = UIImage(named: "eye")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        eyeButton.setImage(eyeImage, for: .normal)
        
        let shareButton = UIButton(type: .custom)
        let shareImage = UIImage(named: "share")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        shareButton.setImage(shareImage, for: .normal)
        
        let favoriteButton = UIButton(type: .custom)
        let favoriteImage = UIImage(named: "favorite")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        favoriteButton.setImage(favoriteImage, for: .normal)
        
        let barButton1 = UIBarButtonItem(customView: favoriteButton)
        let barButton2 = UIBarButtonItem(customView: shareButton)
        let barButton3 = UIBarButtonItem(customView: eyeButton)
        
        barButton1.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        barButton1.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        barButton2.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        barButton2.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        barButton3.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        barButton3.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        let backButton = UIButton(type: .custom)
        let backImage = UIImage(named: "back")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let leftBarButton = UIBarButtonItem(customView: backButton)
        leftBarButton.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        leftBarButton.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.rightBarButtonItems = [barButton1, barButton2, barButton3]
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let vacancyInfoView: VacancyInfoView = {
        let view = VacancyInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lookingDisplayView: UIView = {
        let view = LookingDisplayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let companyLocationView: UIView = {
        let view = CompanyLocationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "MOBYRIX - динамично развивающаяся продуктовая IT-компания, специализирующаяся на разработке мобильных приложений для iOS и Android. Наша команда работает над собственными продуктами в разнообразных сферах: от утилит до развлечений и бизнес-приложений. Мы ценим талант и стремление к инновациям и в данный момент в поиске талантливого UX/UI Designer, готового присоединиться к нашей команде и внести значимый вклад в развитие наших проектов."
        return label
    }()
    
    private let responsibilitiesView: ResponsibilitiesView = {
        let view = ResponsibilitiesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let questionsListView: UIView = {
        let view = QuestionsListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addQuestionsButton(from: ["Где распологается место работы?", "Какой график работы?", "Вакансия открыта?", "Какая оплата труда?"])
        return view
    }()
    
    private let respondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Откликнуться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.specialGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(vacancyInfoView)
        scrollView.addSubview(lookingDisplayView)
        scrollView.addSubview(companyLocationView)
        scrollView.addSubview(descriptionLable)
        scrollView.addSubview(responsibilitiesView)
        scrollView.addSubview(respondButton)
        scrollView.addSubview(questionsListView)
    }
    
    private func activateLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vacancyInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vacancyInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            vacancyInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            vacancyInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 115),
            
            lookingDisplayView.topAnchor.constraint(equalTo: vacancyInfoView.bottomAnchor, constant: 24),
            lookingDisplayView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            lookingDisplayView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14),
            lookingDisplayView.heightAnchor.constraint(equalToConstant: 50),
            
            companyLocationView.topAnchor.constraint(equalTo: lookingDisplayView.bottomAnchor, constant: 23),
            companyLocationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            companyLocationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            companyLocationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 135),
            
            descriptionLable.topAnchor.constraint(equalTo: companyLocationView.bottomAnchor, constant: 16),
            descriptionLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            descriptionLable.heightAnchor.constraint(greaterThanOrEqualToConstant:  0),
            
            responsibilitiesView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 16),
            responsibilitiesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            responsibilitiesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            responsibilitiesView.heightAnchor.constraint(greaterThanOrEqualToConstant:  0),
            //  responsibilitiesView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            questionsListView.topAnchor.constraint(equalTo: responsibilitiesView.bottomAnchor, constant: 32),
            questionsListView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            questionsListView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            questionsListView.heightAnchor.constraint(greaterThanOrEqualToConstant:  0),
            
            respondButton.topAnchor.constraint(equalTo: questionsListView.bottomAnchor, constant: 16),
            respondButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            respondButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            respondButton.heightAnchor.constraint(equalToConstant: 48),
            respondButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
