//
//  QuizView.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit

class QuizView: UIView {
    private let contentStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let personImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        
        return imageView
    }()
    
    private(set) var answerTextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private(set) var resetButton = {
        let button = UIButton()
        button.setTitle("reset", for: .normal)
        button.backgroundColor = .gray
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(personImageView)
        contentStackView.addArrangedSubview(answerTextField)
        contentStackView.addArrangedSubview(resetButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor, multiplier: 1.5)
        ])
    }
}
