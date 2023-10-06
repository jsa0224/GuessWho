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
        stackView.spacing = 30
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
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()
    
    private let personImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private(set) var answerTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.attributedPlaceholder = NSAttributedString(string: "정답", attributes: [.foregroundColor: UIColor.systemGray])

        return textField
    }()

    private(set) var timerLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)

        return label
    }()

    private(set) var answerButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "checkmark.circle", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)

        return button
    }()
    
    private(set) var resetButton = {
        let button = UIButton()
        button.setTitle("reset", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
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
        // 일반 사진
//        personImageView.image = UIImage(named: item.name)
        
        // 흑백 사진
        guard let image = UIImage(named: item.name) else { return }
        personImageView.image = convertToGrayScale(image: image)
    }
    
    private func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(timerLabel)
        contentStackView.addArrangedSubview(personImageView)
        contentStackView.addArrangedSubview(answerStackView)
        contentStackView.addArrangedSubview(resetButton)
        answerStackView.addArrangedSubview(answerTextField)
        answerStackView.addArrangedSubview(answerButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor, multiplier: 1.5),
            answerTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
        ])
    }
    
    private func convertToGrayScale(image: UIImage) -> UIImage? {
        let imageRect: CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        if let cgImage = image.cgImage {
            context?.draw(cgImage, in: imageRect)
            
            if let makeImage = context?.makeImage() {
                let imageRef = makeImage
                let newImage = UIImage(cgImage: imageRef)
                
                return newImage
            }
        }
        
        return UIImage()
    }
}
