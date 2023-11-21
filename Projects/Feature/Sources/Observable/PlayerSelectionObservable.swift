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
    var isEditedHuman: UUID?
    var humans: [Human] = [Human]()

    init(team: Team, lineup: Lineup, currentIndex: Int) {
        self.team = team
        self.lineup = lineup
        self.currentIndex = currentIndex
        self.humans = team.teamMembers
        sortHumans()
    }

    func sortHumans() {
        self.humans = []
        for human in team.teamMembers where lineup.players.firstIndex(where: { $0.human?.id == human.id}) == nil {
            humans.append(human)
        }
        for human in team.teamMembers where lineup.players.firstIndex(where: { $0.human?.id == human.id}) != nil {
            humans.append(human)
        }
    }

    func addPlayer() {
        team.teamMembers.append(InitTeamContainer.makeHuman(name: "새로운 선수", backNumber: 1))
        sortHumans()
    }

    func selectPlayer(_ registerHuman: Human) {
        guard let index = lineup.selectionPlayerIndex else { return }
        if lineup.players[index].human == nil {
            if let registerdIndex = lineup.players.firstIndex(where: { $0.human?.id == registerHuman.id}) {
                lineup.players[registerdIndex].human = nil
            }
            lineup.players[index].human = registerHuman
        } else {
            if let registerdIndex = lineup.players.firstIndex(where: { $0.human?.id == registerHuman.id}) {
                if lineup.players[index].human?.id == registerHuman.id {
                    lineup.players[index].human = nil
                } else {
                    lineup.players[registerdIndex].human = lineup.players[index].human
                    lineup.players[index].human = registerHuman
                }
            } else {
                lineup.players[index].human = registerHuman
            }
        }
        lineup.selectionPlayerIndex = nil
        sortHumans()
    }
}
