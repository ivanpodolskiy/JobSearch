//
//  ApplicantLoginView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

class ApplicantLoginView: UIView  {
    private var showsError: Bool  {
        get { return self.showsError}
        set {
            switch newValue {
            case true:
                stackView.addArrangedSubview(errorLabel)
                textField.layer.borderWidth = 2
                textField.layer.borderColor = UIColor.red.cgColor
            case false:
                errorLabel.removeFromSuperview()
                textField.layer.borderWidth = 0
            }
            
        }
    }
    var buttonAction: ((String) -> Void)?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .red
        label.text = "Вы ввели неверный e-mail"
        return label
    }()
    
    private var cancellable:  AnyCancellable? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayerAndColor()
        setSubviews()
        activateLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        cancellable = textField.customTextField.textPublisher
            .sink { [weak self] text in
                guard let self = self else { return }
                
                print ( !text.isEmpty)
                self.showsError = false
                self.nextButton.isEnabled = !text.isEmpty
                self.nextButton.backgroundColor = !text.isEmpty ? .specialBlue : .specialDarkBlue
                self.nextButton.setTitleColor(!text.isEmpty ? .white : .specialGrey3, for: .normal)
            }
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
        label.text = "Поиск работы"
        return label
    }()
    
    private  let textField: LoginTextField = {
        let textField = LoginTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.backgroundColor = .specialDarkBlue
        button.setTitleColor(.specialGrey3, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        
        let attributedString = NSAttributedString(string: "Продолжить", attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginWithPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.specialBlue]
        let attributedString = NSAttributedString(string: "Войти с паролем", attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    private func setSubviews() {
        addSubview(titleLable)
        addSubview(stackView)
        stackView.addArrangedSubview(textField)
        addSubview(nextButton)
        addSubview(loginWithPasswordButton)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nextButton.widthAnchor.constraint(equalToConstant: 167),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            
            loginWithPasswordButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            loginWithPasswordButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
    
    @objc private func  buttonTapped(_ sender: UIButton) {
        guard let text = textField.customTextField.text else { return }
        if  text.isValidEmail() {
            buttonAction?(text)
        } else {
            showsError = true
        }
    }
}
