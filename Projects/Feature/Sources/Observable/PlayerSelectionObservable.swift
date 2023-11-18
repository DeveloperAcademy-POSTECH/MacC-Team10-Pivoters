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

    init(playerList: [Player] = [], lineup: Lineup) {
        self.playerList = playerList
        self.lineup = lineup
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
        if lineup.players[index].name == " " {
            if registerPlayer.id != nil {
                if let registeredIndex = lineup.players.firstIndex(where: { $0.id == registerPlayer.id }) {
                    let clearPlayer = Player(id: registerPlayer.id,
                                             name: " ",
                                             number: registerPlayer.number,
                                             isGoalkeeper: registerPlayer.isGoalkeeper,
                                             offset: registerPlayer.offset)
                    lineup.players[registeredIndex] = clearPlayer
                }
            }
            registerPlayer.offset = lineup.players[index].offset
            registerPlayer.isGoalkeeper = lineup.players[index].isGoalkeeper
            registerPlayer.number = lineup.players[index].number
            registerPlayer.id = lineup.players[index].id
            lineup.players[index] = registerPlayer
        } else {
            if registerPlayer.id != nil {
                let swapOffset = lineup.players[index].offset
                lineup.players[index].offset = registerPlayer.offset
                registerPlayer.offset = swapOffset
            } else {
                registerPlayer.offset = lineup.players[index].offset
                registerPlayer.isGoalkeeper = lineup.players[index].isGoalkeeper
                registerPlayer.number = lineup.players[index].number
                registerPlayer.id = lineup.players[index].id
                lineup.players[index].id = nil
                lineup.players[index] = registerPlayer
            }
        }
    }
}
