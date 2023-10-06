//
//  Reactive.swift
//  GuessWho
//
//  Created by 정선아 on 2023/10/06.
//

import UIKit
import RxSwift
import RxCocoa

extension RxSwift.Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear))
            .map { _ in }

        return ControlEvent(events: source)
    }
}

