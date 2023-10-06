//
//  DataRepository.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation
import RxSwift

protocol DataRepository {
    func fetchGame() -> Observable<Celebrity>
}
