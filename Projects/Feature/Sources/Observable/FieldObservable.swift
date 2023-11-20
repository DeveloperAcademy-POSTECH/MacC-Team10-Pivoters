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
    var players: [Player] = [Player]()

    init(lineup: Lineup) {
        self.lineup = lineup
        self.players = lineup.players.sorted { $0.number < $1.number }
    }

    func changeFormation(_ formationType: TypeOfFormation) {
        let formationOffsets: [CGSize] = formationType.returnPosition()

        for index in 0..<formationOffsets.count {
            players[index].offset.accumulatedOffsetWidth = formationOffsets[index].width
            players[index].offset.accumulatedOffsetHeight = formationOffsets[index].height
            players[index].offset.draggedOffsetWidth = formationOffsets[index].width
            players[index].offset.draggedOffsetHeight = formationOffsets[index].height
        }
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
