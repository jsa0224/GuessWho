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

    func fetchGameList(by occupation: Occupation) -> Observable<[Celebrity]> {
        return Observable.create { [weak self] emitter in
            var result: [Celebrity] = []

            for _ in 1...5 {
                guard let request = self?.data.celebrities
                    .filter({ $0.occupation == occupation })
                else {
                    emitter.onError(DataError.readFail)
                    return Disposables.create()
                }

                result.append(contentsOf: request)
            }

            emitter.onNext(result)
            emitter.onCompleted()

            return Disposables.create()
        }
    }
}
