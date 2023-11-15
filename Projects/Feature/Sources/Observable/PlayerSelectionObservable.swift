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
    var playerList: [Player]
    var lineup: Lineup
    init(playerList: [Player] = [], lineup: Lineup) {
        self.playerList = playerList
        self.lineup = lineup
    }

    func addPlayer() {
        playerList.append(Player(name: "새로 추가된 선수", number: 1, isGoalkeeper: false, offset: OffsetValue()))
    }

    func selectPlayer(_ player: Player) {
        guard let index = lineup.selectionPlayerIndex else { return }
        if lineup.players[index].name == " " {
            if player.id != nil {
                for positionIndex in 0..<lineup.players.count {
                    if lineup.players[positionIndex].id == player.id {
                        let human = Player(id: player.id,
                                           name: " ",
                                           number: player.number,
                                           isGoalkeeper: player.isGoalkeeper,
                                           offset: player.offset
                        )

                        lineup.players[positionIndex] = human
                    }
                }
            }
            player.offset = lineup.players[index].offset
            player.isGoalkeeper = lineup.players[index].isGoalkeeper
            player.number = lineup.players[index].number
            player.id = lineup.players[index].id

            lineup.players[index] = player
        } else {
            if player.id != nil {
                for positionIndex in 0..<lineup.players.count {
                    if lineup.players[positionIndex].id == player.id {
                        let swapOffset = lineup.players[index].offset
                        lineup.players[index].offset = player.offset
                        player.offset = swapOffset
                    }
                }
            } else {
                player.offset = lineup.players[index].offset
                player.isGoalkeeper = lineup.players[index].isGoalkeeper
                player.number = lineup.players[index].number
                player.id = lineup.players[index].id

                lineup.players[index].id = nil
                lineup.players[index] = player
            }
        }
    }
}
