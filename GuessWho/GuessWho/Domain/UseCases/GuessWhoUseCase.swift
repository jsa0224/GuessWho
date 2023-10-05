//
//  GuessWhoUseCase.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation
import RxSwift

protocol GuessWhoUseCase {
    func fetchGameList(by occupation: Occupation) -> Observable<[Celebrity]>
}

final class DefaultGuessWhoUseCase: GuessWhoUseCase {
    private let guessWhoRepository: GuessWhoRepository

    init(guessWhoRepository: GuessWhoRepository) {
        self.guessWhoRepository = guessWhoRepository
    }

    func fetchGameList(by occupation: Occupation) -> Observable<[Celebrity]> {
        return guessWhoRepository.fetchGameList(by: occupation)
    }
}
