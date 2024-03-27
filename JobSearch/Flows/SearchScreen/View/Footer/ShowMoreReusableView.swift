//
//  ShowMoreReusableView.swift
//  JobSearch
//
//  Created by user on 18.03.2024.
//

import UIKit

class ShowMoreReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(showMorebutton)
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let showMorebutton: UIButton = {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        let attributedString = NSAttributedString(string: "", attributes: attributes)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .specialBlue
        button.setTitleColor(.white, for: .normal)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    func setText(vacancyCount: Int) {
        showMorebutton.setTitle("Еще \(vacancyCount) вакансии", for: .normal)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            showMorebutton.topAnchor.constraint(equalTo: topAnchor),
            showMorebutton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            showMorebutton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            showMorebutton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ShowMoreReusableView: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
