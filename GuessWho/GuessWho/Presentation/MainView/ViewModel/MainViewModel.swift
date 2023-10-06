//
//  MainViewModel.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/06.
//

import Foundation
import RxSwift

final class MainViewModel {
    struct Input {
        let didTapStartButton: Observable<Void>
        let didTapAnswerButton: Observable<Void>
        let didTextingAnswerText: Observable<String>
        let passNextGame: Observable<Void>
        let didTapResetButton: Observable<Void>
    }

    struct Output {
        let game: Observable<Celebrity>
        let answerSaving: Observable<Void>
        let isCorrect: Observable<Bool>
    }

    private let guessWhoUseCase: GuessWhoUseCase
    private var answerText: String = ""

    init(guessWhoUseCase: GuessWhoUseCase) {
        self.guessWhoUseCase = guessWhoUseCase
    }

    func transform(_ input: Input) -> Output {
        let game = Observable.merge(input.didTapStartButton,
                                    input.passNextGame,
                                    input.didTapResetButton)
            .withUnretained(self)
            .flatMap { owner, occupation in
                owner
                    .guessWhoUseCase
                    .fetchGame()
            }
            .share()

        let answerSaving = input.didTextingAnswerText
            .withUnretained(self)
            .map { owner, name in
                owner.answerText = name
            }

        let isCorrect = input.didTapAnswerButton
            .withLatestFrom(game)
            .withUnretained(self)
            .map { owner, game in
                game.name == owner.answerText
            }

        return Output(game: game,
                      answerSaving: answerSaving,
                      isCorrect: isCorrect)
    }
}
