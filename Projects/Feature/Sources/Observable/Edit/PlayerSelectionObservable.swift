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
    let currentIndex: Int
    var humans: [Human] = [Human]()
    var players: [Player] = [Player]()
    var isChangeAddPlayerPresented: Bool = false
    var isChangeEditPlayerPresented: Bool = false
    var editHuman: Human?

    init(team: Team, lineup: Lineup, currentIndex: Int) {
        self.team = team
        self.lineup = lineup
        self.currentIndex = currentIndex
        self.humans = team.teamMembers
        self.players = lineup.players.sorted { $0.number < $1.number }
        sortHumans()
    }

    func sortHumans() {
        self.humans = []
        var selectHumans: [Human] = []
        for human in team.teamMembers {
            if let index = players.firstIndex(where: { $0.human?.id == human.id}) {
                if index < lineup.formation.rawValue {
                    selectHumans.append(human)
                } else {
                    humans.append(human)
                }
            } else {
                humans.append(human)
            }
        }
        humans += selectHumans
    }

    func addPlayer() {
        team.teamMembers.insert(InitTeamContainer.makeHuman(name: String(localized: "New Player"),
                                                            backNumber: 1),
                                at: 0)
        sortHumans()
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
                if players[index].human?.id == registerHuman.id {
                    players[index].human = nil
                } else {
                    players[registerdIndex].human = players[index].human
                    players[index].human = registerHuman
                }
            } else {
                players[index].human = registerHuman
            }
        }
        lineup.selectionPlayerIndex = nil
        sortHumans()
    }
}
