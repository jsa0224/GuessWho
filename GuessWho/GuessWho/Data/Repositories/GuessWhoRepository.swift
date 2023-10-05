//
//  GuessWhoRepository.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation
import RxSwift

final class GuessWhoRepository: DataRepository {
    private let dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func fetchGameList(by occupation: Occupation) -> RxSwift.Observable<[Celebrity]> {
        <#code#>
    }


}
