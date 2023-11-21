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
    var team: Team
    var lineup: Lineup
    var players: [Player] = [Player]()
    let currentIndex: Int

    init(team: Team, lineup: Lineup, currentIndex: Int) {
        self.team = team
        self.lineup = lineup
        self.players = lineup.players.sorted { $0.number < $1.number }
        self.currentIndex = currentIndex
    }

    func addPlayer() {
        team.teamMembers.append(InitTeamContainer.makeHuman(name: String(localized: "New Player"), backNumber: 1))
    }

    func selectPlayer(_ registerHuman: Human) {
        guard let index = lineup.selectionPlayerIndex else { return }
        if players[index].human == nil {
            if let registerdIndex = players.firstIndex(where: { $0.human?.id == registerHuman.id}) {
                players[registerdIndex].human = nil
            }
            players[index].human = registerHuman
        } else {
            if let registerdIndex = players.firstIndex(where: { $0.human?.id == registerHuman.id}) {
                players[registerdIndex].human = players[index].human
                players[index].human = registerHuman
            } else {
                players[index].human = registerHuman
            }
        }
    }
}
