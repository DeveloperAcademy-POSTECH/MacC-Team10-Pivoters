//
//  TeamContainer.swift
//  Core
//
//  Created by 한지석 on 11/18/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public typealias Team = LinableSchemaV1.Team
public typealias Lineup = LinableSchemaV1.Lineup
public typealias Player = LinableSchemaV1.Player
public typealias TeamPlayer = LinableSchemaV1.TeamPlayer

// MARK: 컨테이너 호출 시 Cannot use staged migration with an unknown model version 에러 발생

@MainActor
public let linableContainer: ModelContainer = {
    do {
        let schema = Schema([Team.self, Lineup.self, Player.self, TeamPlayer.self])
        let configuration = ModelConfiguration()
        let container = try ModelContainer(for: schema,
                                           configurations: [configuration])
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Team>()).isEmpty {
            let team = InitLinable.makeTheFirstTeam()
            container.mainContext.insert(team)
        }
        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()
