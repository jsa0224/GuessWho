//
//  Celebrity.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation

struct Celebrity {
    let name: String
    let occupation: Occupation
}

enum Occupation {
    case idol
    case comedian
    case actor
}
