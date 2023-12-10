//
//  TeamContainer.swift
//  Core
//
//  Created by 한지석 on 11/18/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public enum TeamMigrationPlan: SchemaMigrationPlan {

    public static var schemas: [VersionedSchema.Type] {
        [TeamSchemaV1.self, TeamSchemaV2.self]
    }

    public static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    public static let migrateV1toV2 = MigrationStage.custom(fromVersion: TeamSchemaV1.self,
                                                            toVersion: TeamSchemaV2.self,
                                                            willMigrate: nil,
                                                            didMigrate: nil)

}

public typealias Team = TeamSchemaV1.Team
public typealias Lineup = TeamSchemaV1.Lineup

@MainActor
public let teamContainer: ModelContainer = {
    do {
        // MARK: 컨테이너 호출 시 Cannot use staged migration with an unknown model version 에러 발생
        let schema = Schema([Team.self])
        let configuration = ModelConfiguration()
        let container = try ModelContainer(for: schema, configurations: [configuration])
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
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                goalkeeperPrimaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                goalkeeperSecondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                theme: .blueGray),
         Lineup(id: UUID(),
                index: 1,
                lineupName: String(localized: "Lineup 2"),
                uniform: .plain,
                formation: .eleven,
                selectedTypeOfFormation: .football433,
                players: makePlayers(),
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                goalkeeperPrimaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                goalkeeperSecondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                theme: .blueGray),
         Lineup(id: UUID(),
                index: 2,
                lineupName: String(localized: "Lineup 3"),
                uniform: .plain,
                formation: .eleven,
                selectedTypeOfFormation: .football433,
                players: makePlayers(),
                primaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                secondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                goalkeeperPrimaryColor: UniformColor(red: 0.921569, green: 0.921569, blue: 0.921569),
                goalkeeperSecondaryColor: UniformColor(red: 0.6, green: 0.6, blue: 0.6),
                theme: .blueGray)
        ]
    }

    /// 나중에 formaiton을 파라미터로 받아와서 플레이어의 갯수 리턴을 switch하면 될듯하다.
    static func makePlayers() -> [Player] {
        [
            Player(id: UUID(),
                   number: 1,
                   isGoalkeeper: true,
                   offset: OffsetValue(draggedOffsetWidth: 0,
                                       draggedOffsetHeight: 107,
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


//public typealias Team = TeamSchemaV2.Team
