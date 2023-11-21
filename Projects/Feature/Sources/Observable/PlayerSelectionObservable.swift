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
        team.teamMembers.append(InitTeamContainer.makeHuman(name: "새로운 선수", backNumber: 1))
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

//    func selectPlayer(_ registerPlayer: Player) {
//        guard let index = lineup.selectionPlayerIndex else { return }
//        if lineup.players[index].name == " " {
//            if registerPlayer.id != nil {
//                if let registeredIndex = lineup.players.firstIndex(where: { $0.id == registerPlayer.id }) {
//                    let clearPlayer = Player(id: registerPlayer.id,
//                                             name: " ",
//                                             number: registerPlayer.number,
//                                             isGoalkeeper: registerPlayer.isGoalkeeper,
//                                             offset: registerPlayer.offset)
//                    lineup.players[registeredIndex] = clearPlayer
//                }
//            }
//            registerPlayer.offset = lineup.players[index].offset
//            registerPlayer.isGoalkeeper = lineup.players[index].isGoalkeeper
//            registerPlayer.number = lineup.players[index].number
//            registerPlayer.id = lineup.players[index].id
//            lineup.players[index] = registerPlayer
//        } else {
//            if registerPlayer.id != nil {
//                let swapPlayer = lineup.players[index].offset
//                lineup.players[index].offset = registerPlayer.offset
//                registerPlayer.offset = swapPlayer
//
//            } else {
//                registerPlayer.offset = lineup.players[index].offset
//                registerPlayer.isGoalkeeper = lineup.players[index].isGoalkeeper
//                registerPlayer.number = lineup.players[index].number
//                registerPlayer.id = lineup.players[index].id
//                lineup.players[index].id = nil
//                lineup.players[index] = registerPlayer
//            }
//        }
//    }
//    func selectPlayer(_ registerPlayer: Player) {
//            guard let index = lineup.selectionPlayerIndex,
//                  let lineupIndex = lineup.players.firstIndex(where: { $0.number == players[index].number })
//            else { return }
//            if players[index].name == " " {
//                if registerPlayer.id != nil {
//                    if let registeredIndex = players.firstIndex(where: { $0.id == registerPlayer.id }),
//                       let lineupRegisteredIndex = lineup.players.firstIndex(where: { $0.id == registerPlayer.id })
//                    {
//                        let clearPlayer = Player(id: registerPlayer.id,
//                                                 name: " ",
//                                                 number: registerPlayer.number,
//                                                 isGoalkeeper: registerPlayer.isGoalkeeper,
//                                                 offset: registerPlayer.offset)
//                        players[registeredIndex] = clearPlayer
//                        lineup.players[lineupRegisteredIndex] = clearPlayer
//                    }
//                }
//                registerPlayer.offset = players[index].offset
//                registerPlayer.isGoalkeeper = players[index].isGoalkeeper
//                registerPlayer.number = players[index].number
//                registerPlayer.id = players[index].id
//                players[index] = registerPlayer
//                lineup.players[lineupIndex] = registerPlayer
//            } else {
//                if registerPlayer.id != nil {
//                    let swapOffset = players[index].offset
//                    players[index].offset = registerPlayer.offset
//                    lineup.players[lineupIndex].offset = registerPlayer.offset
//                    registerPlayer.offset = swapOffset
//                } else {
//                    registerPlayer.offset = players[index].offset
//                    registerPlayer.isGoalkeeper = players[index].isGoalkeeper
//                    registerPlayer.number = players[index].number
//                    registerPlayer.id = players[index].id
//                    lineup.players[lineupIndex].id = nil
//                    lineup.players[lineupIndex] = registerPlayer
//                    players[index].id = nil
//                    players[index] = registerPlayer
//                }
//            }
//        }

}
