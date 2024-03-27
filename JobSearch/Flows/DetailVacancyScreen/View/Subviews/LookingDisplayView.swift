//
//  LookingDisplayView.swift
//  JobSearch
//
//  Created by user on 17.03.2024.
//

import UIKit

class LookingDisplayView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        activateLayout()
    }
    func setData(appliedText: String, lookingText: String){
        appliedNumberView.setText(appliedText)
        lookingNumberView.setText(lookingText)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var appliedNumberView: LookingView = {
        let view = LookingView(icon: .appliedView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let lookingNumberView: LookingView = {
        let view = LookingView(icon: .lookingView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private func setSubviews(){
        addSubview(appliedNumberView)
        addSubview(lookingNumberView)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            appliedNumberView.topAnchor.constraint(equalTo: topAnchor),
            appliedNumberView.leftAnchor.constraint(equalTo: leftAnchor),
            appliedNumberView.bottomAnchor.constraint(equalTo: bottomAnchor),
            appliedNumberView.rightAnchor.constraint(equalTo: centerXAnchor, constant: -3),
            
            lookingNumberView.topAnchor.constraint(equalTo: topAnchor),
            lookingNumberView.leftAnchor.constraint(equalTo: centerXAnchor, constant: 3),
            lookingNumberView.rightAnchor.constraint(equalTo: rightAnchor),
            lookingNumberView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
