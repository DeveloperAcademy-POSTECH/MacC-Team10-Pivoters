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

    var isChangeTeamInfoPresented: Bool = false
    var isChangeLineupInfoPresented: Bool = false
    var team: Team
    var lineup: Lineup
    var players: [Player] = [Player]()

    init(team: Team, lineup: Lineup) {
        self.team = team
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

    func changePlayerNumber(_ playerCount: Int) {
        switch playerCount {
        case 5:
            lineup.formation = .five
            changeFormation(.futsal22)
            lineup.selectedTypeOfFormation = .futsal22
        case 6:
            lineup.formation = .six
            changeFormation(.futsal212)
            lineup.selectedTypeOfFormation = .futsal212
        case 11:
            lineup.formation = .eleven
            changeFormation(.football433)
            lineup.selectedTypeOfFormation = .football433
        default:
            lineup.formation = .eleven
            changeFormation(.football433)
            lineup.selectedTypeOfFormation = .football433
        }
    }
}
