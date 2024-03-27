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
        setupNavigation()
        setSubviews()
        activateLayout()
    }
    func loadData(_ item: VacancyItem) {
        let lookingAppliedNumber = item.lookingAppliedNumber
        vacancyInfoView.loadData(vacancyDetail: item.vacancyDetail)
        lookingDisplayView.setData(appliedText: 
                                    formatAppliedNumber(lookingAppliedNumber?.appliedNumber ?? 0),
                                   lookingText: formatLookingNumber(lookingAppliedNumber?.lookingNumber ?? 0))
        companyLocationView.setData(address: item.address, company: item.company)
        responsibilitiesView.setText(item.vacancyDetail.responsibilities)
        questionsListView.addQuestionsButton(from: item.questions)
        descriptionLable.text = item.description
    }
    
    
    private func formatAppliedNumber(_ appliedNumber: Int) -> String {
        if appliedNumber == 0 { return "Никто не откликнулся" }
        let suffix = appliedNumber % 10 == 1 && appliedNumber % 100 != 11 ? "а" : ""

        let word = appliedNumber % 10 == 1 && appliedNumber % 100 != 11 ?  "откликнулся" : "откликнулось"
        return "\(appliedNumber) человек\(suffix) уже \(word)"
    }

    private func formatLookingNumber(_ lookingNumber: Int) -> String {
        if lookingNumber == 0 { return "Никто сейчас не смотрит"}
        let suffix = lookingNumber % 10 == 1 && lookingNumber % 100 != 11 ? "а" : ""
        let word = lookingNumber % 10 == 1 && lookingNumber % 100 != 11 ?  "смотрит" : "смотрят"
        return "\(lookingNumber) человек\(suffix) сейчас \(word)"
    }
    
    private let scrollView = UIScrollView()
    
    private let vacancyInfoView =  VacancyInfoView()
    private let lookingDisplayView = LookingDisplayView()
    
    private let companyLocationView = CompanyLocationView()
    private let responsibilitiesView = ResponsibilitiesView()
    private let questionsListView = QuestionsListView()

    private lazy var descriptionLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let respondButton: UIButton = {
        let button = UIButton()
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        vacancyInfoView.translatesAutoresizingMaskIntoConstraints = false
        lookingDisplayView.translatesAutoresizingMaskIntoConstraints = false
        companyLocationView.translatesAutoresizingMaskIntoConstraints = false
        responsibilitiesView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        questionsListView.translatesAutoresizingMaskIntoConstraints = false
        respondButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vacancyInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vacancyInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            vacancyInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            vacancyInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
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

extension DetailVacancyViewController {
    private func setupNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .black
        
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
}
