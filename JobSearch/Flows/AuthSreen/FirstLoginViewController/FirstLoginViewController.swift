//
//  LoginViewController.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit
import Combine

class FirstLoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubiews()
        activateLayout()
        applicantLoginView.buttonAction = {[weak self] mail in
            guard let self = self else { return }
            print (mail)
            let newScreen = SecondLoginViewController(mail: mail)
            present(newScreen, animated: true)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "Вход в личный кабинет"
        return label
    }()
    private let applicantLoginView: ApplicantLoginView = {
        let view = ApplicantLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let employerLoginView:  EmployerLoginView = {
        let view = EmployerLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private func setSubiews() {
        view.addSubview(titleLabel)
        view.addSubview(applicantLoginView)
        view.addSubview(employerLoginView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            applicantLoginView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 144),
            applicantLoginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            applicantLoginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            employerLoginView.topAnchor.constraint(equalTo: applicantLoginView.bottomAnchor, constant: 18),
            employerLoginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            employerLoginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
    }
}
