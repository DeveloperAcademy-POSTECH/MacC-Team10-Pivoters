//
//  ModelContainer.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public typealias Team = SchemaV1.Team
public typealias Lineup = SchemaV1.Lineup
public typealias Player = SchemaV1.Player
public typealias TeamPlayer = SchemaV1.TeamPlayer

@MainActor
public let modelContainer: ModelContainer = {
    do {
        let schema = Schema([Team.self, Lineup.self, Player.self, TeamPlayer.self])
        let configuration = ModelConfiguration()
        let container = try ModelContainer(for: schema,
                                           configurations: [configuration])
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Team>()).isEmpty {
            let team = InitData.makeTheFirstTeam()
            container.mainContext.insert(team)
        }
        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()
