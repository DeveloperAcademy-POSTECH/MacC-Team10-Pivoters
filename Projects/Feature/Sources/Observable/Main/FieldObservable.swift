//
//  FieldObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
class FieldObservable {
    var team: Team
    var lineup: Lineup
    var players: [Player] = [Player]()

    init(team: Team, lineup: Lineup) {
        self.team = team
        self.lineup = lineup
        self.players = lineup.players.sorted { $0.number < $1.number }
    }
}
