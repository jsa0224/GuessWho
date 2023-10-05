//
//  MainView.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit

class MainView: UIView {
    private let titleImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private(set) var startButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
        addSubview(titleImageView)
        addSubview(startButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 323),
            titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleImageView.widthAnchor.constraint(equalToConstant: 314),
            titleImageView.heightAnchor.constraint(equalToConstant: 63),
            startButton.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 100),
            startButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
