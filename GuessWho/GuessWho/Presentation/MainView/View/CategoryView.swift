//
//  CategoryView.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit

class CategoryView: UIView {
    private let categoryStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private(set) var comedianButton = {
        let button = UIButton()
        button.setTitle("코미디언", for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    private(set) var actorButton = {
        let button = UIButton()
        button.setTitle("배우", for: .normal)
        button.backgroundColor = .blue
        
        return button
    }()
    
    private(set) var idolButton = {
        let button = UIButton()
        button.setTitle("아이돌", for: .normal)
        button.backgroundColor = .blue
        
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
        addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(comedianButton)
        categoryStackView.addArrangedSubview(actorButton)
        categoryStackView.addArrangedSubview(idolButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            categoryStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            categoryStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            categoryStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
