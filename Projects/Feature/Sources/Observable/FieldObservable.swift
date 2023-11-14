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
        player.offset = lineup.players[index].offset
        player.isGoalkeeper = lineup.players[index].isGoalkeeper
        player.number = lineup.players[index].number
        player.id = lineup.players[index].id

        lineup.players[index] = player
    }
}
