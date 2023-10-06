//
//  MainView.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit

class MainView: UIView {
    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let titleImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    private(set) var startButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImageView() {
        titleImageView.image = UIImage(named: "logo")
    }
    
    private func configure() {
        backgroundColor = UIColor(named: "mainColor")
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleImageView)
        mainStackView.addArrangedSubview(startButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
        ])
    }
}
