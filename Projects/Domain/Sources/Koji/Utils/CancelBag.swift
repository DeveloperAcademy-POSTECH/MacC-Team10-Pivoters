//
//  CancelBag.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Combine

public final class CancelBag {
    fileprivate(set) var subsriptions = Set<AnyCancellable>()

    func cancel() {
        subsriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subsriptions.insert(self)
    }
}
