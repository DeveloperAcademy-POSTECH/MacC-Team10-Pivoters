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
    var teamPlayers: [TeamPlayer] = [TeamPlayer]()
    var players: [Player] = [Player]()
    var isChangeAddPlayerPresented: Bool = false
    var isChangeEditPlayerPresented: Bool = false
    var editTeamPlayer: TeamPlayer?

    init(team: Team, 
         lineup: Lineup,
         currentIndex: Int) {
        self.team = team
        self.lineup = lineup
        self.currentIndex = currentIndex
        self.teamPlayers = team.teamPlayers
        self.players = lineup.players.sorted { $0.number < $1.number }
        sortTeamPlayers()
    }

    // MARK: 제대로 작동하는지 확인해야 함.

    func sortTeamPlayers() {
        self.teamPlayers = []
        var selectedTeamPlayers: [TeamPlayer] = []
        for teamPlayer in team.teamPlayers {
            if let index = players.firstIndex(where: { $0.teamPlayer?.id == teamPlayer.id}) {
                if index < lineup.selectedPlayType {
                    selectedTeamPlayers.append(teamPlayer)
                } else {
                    teamPlayers.append(teamPlayer)
                }
            } else {
                teamPlayers.append(teamPlayer)
            }
        }
        teamPlayers.sort(by: { $0.name < $1.name })
        selectedTeamPlayers.sort(by: { $0.name < $1.name })
        teamPlayers += selectedTeamPlayers
    }

    func addPlayer() {
        team.teamPlayers.insert(InitLinable.makeTeamPlayer(name: String(localized: "New Player"),
                                                            backNumber: 1),
                                at: 0)
        sortTeamPlayers()
    }

    func selectPlayer(_ registerTeamPlayer: TeamPlayer) {
        guard let index = lineup.selectionPlayerIndex else { return }
        if players[index].teamPlayer == nil {
            if let registerdIndex = players.firstIndex(where: { $0.teamPlayer?.id == registerTeamPlayer.id}) {
                players[registerdIndex].teamPlayer = nil
            }
            players[index].teamPlayer = registerTeamPlayer
        } else {
            if let registerdIndex = players.firstIndex(where: { $0.teamPlayer?.id == registerTeamPlayer.id}) {
                if players[index].teamPlayer?.id == registerTeamPlayer.id {
                    players[index].teamPlayer = nil
                } else {
                    players[registerdIndex].teamPlayer = players[index].teamPlayer
                    players[index].teamPlayer = registerTeamPlayer
                }
            } else {
                players[index].teamPlayer = registerTeamPlayer
            }
        }
        lineup.selectionPlayerIndex = nil
        sortTeamPlayers()
    }
}
