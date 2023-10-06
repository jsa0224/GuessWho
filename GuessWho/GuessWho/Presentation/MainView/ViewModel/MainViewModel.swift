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
        let didEndTexting: Observable<String>
        let passNextGame: Observable<Void>
        let didTapResetButton: Observable<Void>
    }

    struct Output {
        let game: Observable<Celebrity>
        let isCorrect: Observable<Bool>
    }

    private let guessWhoUseCase: GuessWhoUseCase

    init(guessWhoUseCase: GuessWhoUseCase) {
        self.guessWhoUseCase = guessWhoUseCase
    }

    func transform(_ input: Input) -> Output {
        let game = Observable.merge(input.didTapStartButton,
                                    input.passNextGame)
            .withUnretained(self)
            .flatMap { owner, occupation in
                owner
                    .guessWhoUseCase
                    .fetchGame()
            }

        let isCorrect = input.didEndTexting
            .withUnretained(self)
            .flatMap { owner, name in
                game.map { $0.name == name } // 이름이 맞으면 통과 / 아니면 아니라는 얼럿
            }


        return Output(game: game,
                      isCorrect: isCorrect)
    }
}
