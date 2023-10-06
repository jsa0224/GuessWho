//
//  GuessWhoUseCase.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation
import RxSwift

protocol GuessWhoUseCase {
    func fetchGame() -> Observable<Celebrity>
}

final class DefaultGuessWhoUseCase: GuessWhoUseCase {
    private let guessWhoRepository: GuessWhoRepository

    init(guessWhoRepository: GuessWhoRepository) {
        self.guessWhoRepository = guessWhoRepository
    }

    func fetchGame() -> Observable<Celebrity> {
        return guessWhoRepository.fetchGame()
    }
}
