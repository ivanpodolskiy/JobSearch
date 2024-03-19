//
//  Extension.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        let textChangePublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { notification -> String? in
                guard let textField = notification.object as? UITextField else { return nil }
                return textField.text
            }
        
        let endEditingPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { notification  -> String? in
                guard let textField = notification.object as? UITextField else { return nil }
                return textField.text
            }
        
        return Publishers.Merge(textChangePublisher, endEditingPublisher)
            .eraseToAnyPublisher() 
    }
      
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
