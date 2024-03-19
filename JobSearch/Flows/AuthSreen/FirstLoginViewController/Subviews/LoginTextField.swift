//
//  LoginTextField.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

class LoginTextField: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayerAndColor()
        setupTextFiled()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let placeholderIcon = UIImage(named: "response")
    
    let customTextField: ClearingTextField = {
        let textField = ClearingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private func setupLayerAndColor() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        backgroundColor = .specialGrey2
    }
    
    private func setupTextFiled() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular), // ваш шрифт
            .foregroundColor: UIColor.gray // ваш цвет текста
        ]
        let placeholderText = NSAttributedString(string: "Электронная почта или телефон", attributes: attributes)
        
        // Установка атрибутированной строки как плейсхолдера
        customTextField.attributedPlaceholder = placeholderText
        // Установка текстового выравнивания
        customTextField.textAlignment = .left
        
        // Создание изображения для плейсхолдера
        let imageView = UIImageView(image: placeholderIcon)
        imageView.contentMode = .center
        
        // Установка изображения в качестве leftView
        customTextField.leftView = imageView
        customTextField.leftViewMode = .unlessEditing
        customTextField.textColor = .white
        addSubview(customTextField)
    }
    
    private func activateLayout() {
        NSLayoutConstraint.activate([
            customTextField.topAnchor.constraint(equalTo: topAnchor),
            customTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            customTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            customTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

class ClearingTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
        
    }
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "clear"), for: .normal)
        return button
    }()
    
    
    private func setupTextField() {
        clearButton.isHidden = true
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    @objc private func textDidChange() {
        clearButton.isHidden = text?.isEmpty ?? true
    }
    
    @objc private func clearButtonTapped(_ sender: UIButton) {
        self.text = ""
        self.sendActions(for: .editingChanged)
    }
}
