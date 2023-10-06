//
//  ViewController.swift
//  GuessWho
//
//  Created by Daehoon Lee on 2023/10/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ViewController: UIViewController {
    private let mainView = MainView()
    private let quizView = QuizView()
    private let viewModel: MainViewModel
    private var disposeBag = DisposeBag()
    private var isCorrectRelay = PublishRelay<Bool>()
    private var timer: Timer?
    private var currentCount = 7


    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    private func bind() {
        let didTapStartButton = mainView.startButton.rx.tap.asObservable()
        let didTapAnswerButton = quizView.answerButton.rx.tap.asObservable()
        let didTextingAnswerText = quizView.answerTextField.rx.text.orEmpty.asObservable()

        let passNextGame = isCorrectRelay
            .map { _ in }

        let didTapResetButton = quizView.resetButton.rx.tap.asObservable()

        let input = MainViewModel.Input(didTapStartButton: didTapStartButton,
                                        didTapAnswerButton: didTapAnswerButton,
                                        didTextingAnswerText: didTextingAnswerText,
                                        passNextGame: passNextGame,
                                        didTapResetButton: didTapResetButton)
        let output = viewModel.transform(input)

        output
            .game
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, game in
                owner.timer?.invalidate()
                owner.quizView.configureView(by: game)
                owner.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                                   selector: #selector(owner.fireTimer),
                                             userInfo: nil,
                                             repeats: true)
                owner.currentCount = 7
            })
            .disposed(by: disposeBag)

        output
            .answerSaving
            .subscribe()
            .disposed(by: disposeBag)

        output
            .isCorrect
            .withUnretained(self)
            .debug()
            .bind(onNext: { owner, bool in
                guard let isValid = owner.timer?.isValid else { return }
                if bool && isValid {
                    owner.quizView.answerTextField.text = nil
                    owner.currentCount = 7
                    owner.isCorrectRelay.accept(true)
                } else {
                    owner.quizView.answerTextField.text = nil
                    owner.currentCount = 7
                    owner.showLoseAlert()
                }
            })
            .disposed(by: disposeBag)

        self.rx.viewWillAppear.asObservable()
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.configureView(contentView: owner.mainView)
            })
            .disposed(by: disposeBag)
        
        mainView.startButton.rx.tap
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.hideView(contentView: owner.mainView)
                owner.configureView(contentView: owner.quizView)
            })
            .disposed(by: disposeBag)
    }

    private func configureUI() {
        view.backgroundColor = UIColor(named: "mainColor")
    }
}

extension ViewController {
    private func configureView(contentView: UIView) {
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func hideView(contentView: UIView) {
        contentView.removeFromSuperview()
    }

    func showLoseAlert() {
        let confirmAction = UIAlertAction(title: "확인",
                                          style: .default) { _ in
            self.dismiss(animated: true)
        }

        let alert = AlertManager.shared
            .setType(.alert)
            .setTitle("Game Over")
            .setMessage(nil)
            .setActions([confirmAction])
            .apply()

        self.present(alert, animated: true)
    }

    @objc func fireTimer() {
        quizView.timerLabel.text = "\(currentCount)"
        currentCount -= 1

//        if currentCount == 3 {
//            quizView.timerLabel.textColor = .systemRed
//        }

        if currentCount == -1 {
            timer?.invalidate()
            currentCount = 7
        }
    }
}


