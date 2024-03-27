//
//  CompanyLocationView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class CompanyLocationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(address: String, company: String) {
        addressLabel.text = address
        companyTitiWithIcon.setText(company)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .specialGrey
        view.layer.cornerRadius = 8
        return view
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let companyTitiWithIcon: CompanyTitiWithIcon = {
        let view = CompanyTitiWithIcon(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let mapLoaction: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "map")
        return imageView
    }()
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private func setSubviews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(companyTitiWithIcon)
        stackView.addArrangedSubview(mapLoaction)
        stackView.addArrangedSubview(addressLabel)
        addSubview(stackView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
