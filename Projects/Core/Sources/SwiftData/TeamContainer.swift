//
//  TeamContainer.swift
//  Core
//
//  Created by 한지석 on 11/18/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@MainActor
public let teamContainer: ModelContainer = {
    do {
        let schema = Schema([Team.self])
        let container = try ModelContainer(for: schema)
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Team>()).isEmpty {
            let team = InitTeamContainer.makeTheFirstTeam()
            container.mainContext.insert(team)
        }
        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()

public struct InitTeamContainer {
    static func makeTheFirstTeam() -> Team {
        Team(id: UUID(),
             teamName: String(localized: "My Team"),
             isSelected: true,
             createdAt: Date(),
             updatedAt: Date(),
             lineup: makeLineup(),
             addedPlayers: [])
    }

    public static func makeTeam(teamName: String) -> Team {
        Team(id: UUID(),
             teamName: teamName,
             isSelected: false,
             createdAt: Date(),
             updatedAt: Date(),
             lineup: makeLineup(),
             addedPlayers: [])
    }

    public static func makeHuman(name: String, backNumber: Int) -> Human {
        Human(name: name, backNumber: backNumber)
    }

    static func makeLineup() -> [Lineup] {
        [Lineup(id: UUID(),
                index: 0,
                lineupName: String(localized: "Lineup 1"),
                uniform: .plain,
                formation: .eleven,
                selectedTypeOfFormation: .football433,
                players: makePlayers(),
                primaryColor: UniformColor(red: 0, green: 0, blue: 0),
                secondaryColor: UniformColor(red: 255, green: 255, blue: 255),
                theme: .blackBlue),
         Lineup(id: UUID(),
                index: 1,
                lineupName: String(localized: "Lineup 2"),
                uniform: .plain,
                formation: .eleven,
                selectedTypeOfFormation: .football433,
                players: makePlayers(),
                primaryColor: UniformColor(red: 0, green: 0, blue: 0),
                secondaryColor: UniformColor(red: 255, green: 255, blue: 255),
                theme: .blackBlue),
         Lineup(id: UUID(),
                index: 2,
                lineupName: String(localized: "Lineup 3"),
                uniform: .plain,
                formation: .eleven,
                selectedTypeOfFormation: .football433,
                players: makePlayers(),
                primaryColor: UniformColor(red: 0, green: 0, blue: 0),
                secondaryColor: UniformColor(red: 255, green: 255, blue: 255),
                theme: .blackBlue)
        ]
    }

    /// 나중에 formaiton을 파라미터로 받아와서 플레이어의 갯수 리턴을 switch하면 될듯하다.
    static func makePlayers() -> [Player] {
        [
            Player(id: UUID(),
                   number: 1,
                   isGoalkeeper: true,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: 100,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: 100)),
            Player(id: UUID(),
                   number: 2,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -75,
                                       draggedOffsetHeight: 50,
                                       accumulatedOffsetWidth: -75,
                                       accumulatedOffsetHeight: 50)),
            Player(id: UUID(),
                   number: 3,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 75,
                                       draggedOffsetHeight: 50,
                                       accumulatedOffsetWidth: 75,
                                       accumulatedOffsetHeight: 50)),
            Player(id: UUID(),
                   number: 4,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 140,
                                       draggedOffsetHeight: 30,
                                       accumulatedOffsetWidth: 140,
                                       accumulatedOffsetHeight: 30)),
            Player(id: UUID(),
                   number: 5,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -140,
                                       draggedOffsetHeight: 30,
                                       accumulatedOffsetWidth: -140,
                                       accumulatedOffsetHeight: 30)),
            Player(id: UUID(),
                   number: 6,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: 20,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: 20)),
            Player(id: UUID(),
                   number: 7,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -70,
                                       draggedOffsetHeight: -20,
                                       accumulatedOffsetWidth: -70,
                                       accumulatedOffsetHeight: -20)),
            Player(id: UUID(),
                   number: 8,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 70,
                                       draggedOffsetHeight: -20,
                                       accumulatedOffsetWidth: 70,
                                       accumulatedOffsetHeight: -20)),
            Player(id: UUID(),
                   number: 9,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: 0,
                                       accumulatedOffsetHeight: -80)),
            Player(id: UUID(),
                   number: 10,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: 130,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: 130,
                                       accumulatedOffsetHeight: -80)),
            Player(id: UUID(),
                   number: 11,
                   isGoalkeeper: false,
                   offset: OffsetValue(draggedOffsetWidth: -130,
                                       draggedOffsetHeight: -80,
                                       accumulatedOffsetWidth: -130,
                                       accumulatedOffsetHeight: -80))
        ]
    }
}
