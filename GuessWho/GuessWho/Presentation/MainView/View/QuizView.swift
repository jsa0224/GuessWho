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
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    private let answerStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let personImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private(set) var answerTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.cornerRadius = 8

        return textField
    }()

    private(set) var answerButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark.circle")
        button.setImage(image, for: .normal)

        return button
    }()
    
    private(set) var resetButton = {
        let button = UIButton()
        button.setTitle("reset", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = UIColor(named: "mainColor")
        configureSubviews()
        configureConstraints()
    }

    func configureView(by item: Celebrity) {
        personImageView.image = UIImage(named: item.name)
    }
    
    private func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(personImageView)
        contentStackView.addArrangedSubview(answerStackView)
        contentStackView.addArrangedSubview(resetButton)
        answerStackView.addArrangedSubview(answerTextField)
        answerStackView.addArrangedSubview(answerButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor, multiplier: 1.5),
            answerTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
        ])
    }
}
