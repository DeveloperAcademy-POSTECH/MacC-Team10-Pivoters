//
//  PlayerSelectionObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/11/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import Core

@Observable
class PlayerSelectionObservable {
    var playerList: [Player] = []

    func addPlayer() {
        playerList.append(Player(name: "새로 추가된 선수", number: 1, isGoalkeeper: false, offset: OffsetValue()))
    }
}
