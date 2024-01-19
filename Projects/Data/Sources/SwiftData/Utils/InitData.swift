//
//  InitData.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public struct InitData {
    static func makeTheFirstTeam() -> SchemaV1.Team {
        SchemaV1.Team(id: UUID(),
             teamName: String(localized: "My Team"),
             isSelected: true,
             createdAt: Date(),
             updatedAt: Date(),
             lineup: makeLineup(),
             teamPlayers: [])
    }

    public static func makeTeam(teamName: String) -> SchemaV1.Team {
        SchemaV1.Team(id: UUID(),
             teamName: teamName,
             isSelected: false,
             createdAt: Date(),
             updatedAt: Date(),
             lineup: makeLineup(),
             teamPlayers: [])
    }

    public static func makeTeamPlayer(name: String, backNumber: Int) -> SchemaV1.TeamPlayer {
        SchemaV1.TeamPlayer(name: name, backNumber: backNumber)
    }

    static func makeLineup() -> [SchemaV1.Lineup] {
        [SchemaV1.Lineup(id: UUID(),
                index: 0,
                lineupName: String(localized: "Lineup 1"),
                selectedUniform: "plain1",
                selectedTheme: "blueGray",
                selectedPlayType: 11,
                selectedFormation: "4-3-3",
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                players: makePlayers()),
         SchemaV1.Lineup(id: UUID(),
                index: 1,
                lineupName: String(localized: "Lineup 2"),
                selectedUniform: "plain1",
                selectedTheme: "blueGray",
                selectedPlayType: 11,
                selectedFormation: "4-3-3",
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                players: makePlayers()),
         SchemaV1.Lineup(id: UUID(),
                index: 2,
                lineupName: String(localized: "Lineup 3"),
                selectedUniform: "plain1",
                selectedTheme: "blueGray",
                selectedPlayType: 11,
                selectedFormation: "4-3-3",
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                players: makePlayers()),
        ]
    }

    /// 나중에 formaiton을 파라미터로 받아와서 플레이어의 갯수 리턴을 switch하면 될듯하다.
    static func makePlayers() -> [SchemaV1.Player] {
        [
            SchemaV1.Player(id: UUID(),
                   number: 1,
                   isGoalkeeper: true,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: 107,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: 100)),
            SchemaV1.Player(id: UUID(),
                   number: 2,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -75,
                                       draggedOffsetHeight: 50,
                                       accumulatedOffsetWidth: -75,
                                       accumulatedOffsetHeight: 50)),
            SchemaV1.Player(id: UUID(),
                   number: 3,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 75,
                                       draggedOffsetHeight: 50,
                                       accumulatedOffsetWidth: 75,
                                       accumulatedOffsetHeight: 50)),
            SchemaV1.Player(id: UUID(),
                   number: 4,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 140,
                                       draggedOffsetHeight: 30,
                                       accumulatedOffsetWidth: 140,
                                       accumulatedOffsetHeight: 30)),
            SchemaV1.Player(id: UUID(),
                   number: 5,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -140,
                                       draggedOffsetHeight: 30,
                                       accumulatedOffsetWidth: -140,
                                       accumulatedOffsetHeight: 30)),
            SchemaV1.Player(id: UUID(),
                   number: 6,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: 20,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: 20)),
            SchemaV1.Player(id: UUID(),
                   number: 7,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -70,
                                       draggedOffsetHeight: -20,
                                       accumulatedOffsetWidth: -70,
                                       accumulatedOffsetHeight: -20)),
            SchemaV1.Player(id: UUID(),
                   number: 8,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 70,
                                       draggedOffsetHeight: -20,
                                       accumulatedOffsetWidth: 70,
                                       accumulatedOffsetHeight: -20)),
            SchemaV1.Player(id: UUID(),
                   number: 9,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: -80)),
            SchemaV1.Player(id: UUID(),
                   number: 10,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 130,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: 130,
                                       accumulatedOffsetHeight: -80)),
            SchemaV1.Player(id: UUID(),
                   number: 11,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -130,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: -130,
                                       accumulatedOffsetHeight: -80))
        ]
    }
}
