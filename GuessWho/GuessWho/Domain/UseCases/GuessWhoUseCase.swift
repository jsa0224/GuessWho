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
    func fetchGameList(by occupation: Occupation) -> RxSwift.Observable<[Celebrity]> {
        <#code#>
    }
}
