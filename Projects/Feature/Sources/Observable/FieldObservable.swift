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
    var selectionPlayerIndex: Int?
    var lineup: Lineup = Lineup(id: UUID(),
                                    uniform: .basic,
                                    headcount: .eleven,
                                    players: MockData.player,
                                    primaryColor: UniformColor(red: 0.4,
                                                               green: 0.4,
                                                               blue: 0.4),
                                    secondaryColor: UniformColor(red: 0.2,
                                                                 green: 0.2,
                                                                 blue: 0.2))

    func changeFormation(_ formationType: FormationType) {
        let formationOffsets: [CGSize] = formationType.returnPosition()

        for index in 0..<formationOffsets.count {
            lineup.players[index].offset.accumulatedOffset = formationOffsets[index]
            lineup.players[index].offset.draggedOffset = formationOffsets[index]
        }
        print("@Log changeFormation")
        print("\(lineup.players[1].offset.draggedOffset.width)")
    }

    func selectPlayer(_ player: Player) {
        guard let index = selectionPlayerIndex else { return }
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
