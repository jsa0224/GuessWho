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
//    private let categoryView = CategoryView()
    private let quizView = QuizView()
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    private var isCorrect = PublishRelay<Bool>()

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
        let didEndTexting = quizView.answerButton.rx.tap
            .withUnretained(self)
            .withLatestFrom(
                quizView.answerTextField.rx.text
                    .orEmpty
            )
            .map { $0 }

        let passNextGame = isCorrect
            .map { _ in }

        let didTapResetButton = quizView.resetButton.rx.tap.asObservable()

        let input = MainViewModel.Input(didTapStartButton: didTapStartButton,
                                        didEndTexting: didEndTexting,
                                        passNextGame: passNextGame,
                                        didTapResetButton: didTapResetButton)
        let output = viewModel.transform(input)

        output
            .game
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, game in
                owner.quizView.configureView(by: game)
            })
            .disposed(by: disposeBag)

        output
            .isCorrect
            .withUnretained(self)
            .bind(onNext: { owner, bool in
                if bool {
                    // TODO: 다음 게임으로 넘어감
                    owner.isCorrect.accept(true)
                } else {
                    // TODO: 얼럿
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

    func showLoseAlert() -> Observable<AlertActionType> {
        return Observable.create { [weak self] emitter in
            let confirmAction = UIAlertAction(title: "확인",
                                              style: .default) { _ in
                emitter.onNext(.ok)
                emitter.onCompleted()
            }

            let alert = AlertManager.shared
                .setType(.alert)
                .setTitle("Game Over")
                .setMessage(nil)
                .setActions([confirmAction])
                .apply()

            self?.navigationController?.present(alert, animated: true)

            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
}

