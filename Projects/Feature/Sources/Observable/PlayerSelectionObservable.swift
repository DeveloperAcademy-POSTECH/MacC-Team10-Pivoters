//
//  PlayerSelectionObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/11/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

import Core

@Observable
class PlayerSelectionObservable {

    var playerList: [Player]
    var lineup: Lineup
    var players: [Player] = [Player]()

    init(playerList: [Player] = [], lineup: Lineup) {
        self.playerList = playerList
        self.lineup = lineup
        self.players = lineup.players.sorted { $0.number < $1.number }
    }

    func addPlayer() {
        playerList.append(Player(name: "\(self.playerList.count)",
                                 number: 7,
                                 isGoalkeeper: false,
                                 offset: OffsetValue(draggedOffsetWidth: 0,
                                                     draggedOffsetHeight: 0,
                                                     accumulatedOffsetWidth: 0,
                                                     accumulatedOffsetHeight: 0)))
    }

    func selectPlayer(_ registerPlayer: Player) {
        guard let index = lineup.selectionPlayerIndex else { return }
        if players[index].name == " " {
            if registerPlayer.id != nil {
                if let registeredIndex = players.firstIndex(where: { $0.id == registerPlayer.id }) {
                    let clearPlayer = Player(id: registerPlayer.id,
                                             name: " ",
                                             number: registerPlayer.number,
                                             isGoalkeeper: registerPlayer.isGoalkeeper,
                                             offset: registerPlayer.offset)
                    players[registeredIndex] = clearPlayer
                }
            }
            registerPlayer.offset = players[index].offset
            registerPlayer.isGoalkeeper = players[index].isGoalkeeper
            registerPlayer.number = players[index].number
            registerPlayer.id = players[index].id
            players[index] = registerPlayer
        } else {
            if registerPlayer.id != nil {
                let swapOffset = players[index].offset
                players[index].offset = registerPlayer.offset
                registerPlayer.offset = swapOffset
            } else {
                registerPlayer.offset = players[index].offset
                registerPlayer.isGoalkeeper = players[index].isGoalkeeper
                registerPlayer.number = players[index].number
                registerPlayer.id = players[index].id
                players[index].id = nil
                players[index] = registerPlayer
            }
        }
    }
}
