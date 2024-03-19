//
//  PresscodeEntryView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

class PresscodeEntryView: UIView, UITextFieldDelegate {
    private var textFields: [UITextField] = []
    private var currentTextFieldIndex = 0
    
    private var cancellables: [AnyCancellable] = []
       private var passwordPublisher = PassthroughSubject<Bool, Never>()
       
       var passwordEnteredPublisher: AnyPublisher<Bool, Never> {
           passwordPublisher.eraseToAnyPublisher()
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextFields()
    }
    
    private func setupTextFields() {
        let digitCount = 4
        let textFieldWidth: CGFloat = 48
        let textFieldSpacing: CGFloat = 8
        let containerWidth = CGFloat(digitCount) * (textFieldWidth + textFieldSpacing)
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: textFieldWidth))
        addSubview(container)
        
        var previousTextField: UITextField?
        for number in 1...digitCount {
            var spacingBetweenFields: CGFloat = 8
            if number == 1 {
                spacingBetweenFields = 0
            }
            let xPosition  = (previousTextField?.frame.maxX ?? 0) + spacingBetweenFields
            let textField = UITextField(frame: CGRect(x: xPosition,
                                                      y: 0,
                                                      width: textFieldWidth,
                                                      height: textFieldWidth))
            textField.delegate = self
            textField.layer.cornerRadius = 8
            textField.backgroundColor = .specialGrey2
            textField.textColor = .gray
            textField.tintColor = .white
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            container.addSubview(textField)
            textFields.append(textField)
            previousTextField = textField
            
            textField.publisher(for: \.text)
                           .compactMap { $0 }
                           .sink { [weak self] _ in
                               self?.checkIfAllFieldsFilled()
                           }
                           .store(in: &cancellables)
        }
    }
    
    private func checkIfAllFieldsFilled() {
        
           let password = textFields.map { $0.text ?? "" }.joined()
           passwordPublisher.send(password.count == textFields.count )
          
       }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let minLength = 1
        
        if let text = textField.text, text.count >= minLength {
            textField.resignFirstResponder()
            focusNextTextField()
        }
    }
    
    private func focusNextTextField() {
        currentTextFieldIndex += 1
        if currentTextFieldIndex < textFields.count {
            textFields[currentTextFieldIndex].becomeFirstResponder()
        }
    }
}

