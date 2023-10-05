//
//  CelebrityData.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/05.
//

import Foundation

struct CelebrityData {
    var celebrities: [Celebrity] = [
        // MARK: 아이돌
        Celebrity(name: "안유진",
                  occupation: .idol),
        Celebrity(name: "장원영",
                  occupation: .idol),
        Celebrity(name: "카리나",
                  occupation: .idol),
        Celebrity(name: "하니",
                  occupation: .idol),
        Celebrity(name: "차은우",
                  occupation: .idol),
        // MARK: 개그맨
        Celebrity(name: "임라라",
                  occupation: .comedian),
        Celebrity(name: "강호동",
                  occupation: .comedian),
        Celebrity(name: "유재석",
                  occupation: .comedian),
        Celebrity(name: "홍윤화",
                  occupation: .comedian),
        Celebrity(name: "박나래",
                  occupation: .comedian),
        // MARK: 배우
        Celebrity(name: "김희애",
                  occupation: .actor),
        Celebrity(name: "정우성",
                  occupation: .actor),
        Celebrity(name: "조인성",
                  occupation: .actor),
        Celebrity(name: "염정아",
                  occupation: .actor),
        Celebrity(name: "손예진",
                  occupation: .actor),
    ]
}
