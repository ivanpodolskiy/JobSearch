//
//  LoginViewController2.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

class SecondLoginViewController: UIViewController {
    private var mail: String
    init(mail: String) {
        self.mail = mail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
        view.backgroundColor = .black
        bind()
        setSubviews()
        activateLayout()
    }
    private let stackView: UIStackView = {
        let stacKView = UIStackView()
        stacKView.translatesAutoresizingMaskIntoConstraints = false
        stacKView.axis = .vertical
        stacKView.alignment = .fill
        stacKView.spacing = 16
        return stacKView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправили код на "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let presscodeView: PresscodeEntryView = {
        let view = PresscodeEntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var cancellable: AnyCancellable? = nil
    private func bind() {
        cancellable = presscodeView.passwordEnteredPublisher
            .sink { [weak self] access in
                print (access)
                guard let self = self else { return }
                self.confirmButton.isEnabled = access
                self.confirmButton.backgroundColor = access ? .specialBlue : .specialDarkBlue
                self.confirmButton.setTitleColor(access ? .white : .specialGrey3, for: .normal)
            }
            
    }
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.backgroundColor = .specialDarkBlue
        button.setTitleColor(.specialGrey3, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        
        let attributedString = NSAttributedString(string: "Подтвердить", attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: .normal)
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapButton(_ sender: UIButton) {
        
    }
    
    private func setSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(presscodeView)
        stackView.addArrangedSubview(confirmButton)
    }
    private func activateLayout(){
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
            presscodeView.heightAnchor.constraint(equalToConstant: 48),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
            
        ])
    }
    
    private func setText() {
        titleLabel.text =  "Отправили код на \(mail)"
        descriptionLabel.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
    }
}
