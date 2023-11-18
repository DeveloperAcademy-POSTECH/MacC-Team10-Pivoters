//
//  FieldObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import Foundation

@Observable
class FieldObservable {
    var lineup: Lineup
    init(lineup: Lineup) {
        self.lineup = lineup
    }

    func changeFormation(_ formationType: TypeOfFormation) {
        let formationOffsets: [CGSize] = formationType.returnPosition()

        for index in 0..<formationOffsets.count {
            lineup.players[index].offset.accumulatedOffsetWidth = formationOffsets[index].width
            lineup.players[index].offset.accumulatedOffsetHeight = formationOffsets[index].height
            lineup.players[index].offset.draggedOffsetWidth = formationOffsets[index].width
            lineup.players[index].offset.draggedOffsetHeight = formationOffsets[index].height
        }
    }

    func selectPlayer(_ player: inout Player) {
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
