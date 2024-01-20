//
//  PlayerUseCase.swift
//  Domain
//
//  Created by 박승찬 on 1/20/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

protocol PlayerUseCase {
    func addPlayer(name: String, backNumber: Int) -> Player
}

class PlayerSelectionUseCase: PlayerUseCase {
    func addPlayer(name: String, backNumber: Int) -> Player {
        Player(id: UUID(), name: name, backNumber: backNumber)
    }
}
