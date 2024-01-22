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
    var team: TeamV1
    var lineup: LineupV1
    var players: [PlayerV1] = [PlayerV1]()

    init(team: TeamV1, lineup: LineupV1) {
        self.team = team
        self.lineup = lineup
        self.players = lineup.players.sorted { $0.number < $1.number }
    }
}
