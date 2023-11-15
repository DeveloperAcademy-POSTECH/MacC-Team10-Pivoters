//
//  TeamManagementObservable.swift
//  Feature
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
final class TeamManagementObservable {
    var lineup: Lineup
    var selectedTypeOfFormation: TypeOfFormation

    init(lineup: Lineup) {
        self.lineup = lineup
        self.selectedTypeOfFormation = lineup.selectedTypeOfFormation
    }

    func changeFormation(_ formationType: TypeOfFormation) {
        let formationOffsets: [CGSize] = formationType.returnPosition()

        for index in 0..<formationOffsets.count {
            lineup.players[index].offset.accumulatedOffset = formationOffsets[index]
            lineup.players[index].offset.draggedOffset = formationOffsets[index]
        }
        print("@Log changeFormation")
        print("\(lineup.players[1].offset.draggedOffset.width)")
    }
}
