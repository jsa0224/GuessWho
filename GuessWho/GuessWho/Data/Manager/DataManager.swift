//
//  DataManager.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation
import RxSwift

final class DataManager {
    private let data: CelebrityData

    init(data: CelebrityData) {
        self.data = data
    }

    func fetchGame() -> Observable<Celebrity> {
        return Observable.create { [weak self] emitter in
            guard let request = self?.data.celebrities
                .randomElement()
            else {
                emitter.onError(DataError.readFail)
                return Disposables.create()
            }

            emitter.onNext(request)
            emitter.onCompleted()

            return Disposables.create()
        }
    }
}
