//
//  DataError.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation

enum DataError: LocalizedError {
    case readFail

    var description: String {
        switch self {
        case .readFail:
            return ErrorMessage.readFail
        }
    }

    private enum ErrorMessage {
        static let readFail = "데이터를 불러올 수 없습니다."
    }
}
