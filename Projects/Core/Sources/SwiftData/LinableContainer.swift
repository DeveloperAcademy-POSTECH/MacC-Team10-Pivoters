//
//  TeamContainer.swift
//  Core
//
//  Created by 한지석 on 11/18/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData



// MARK: 컨테이너 호출 시 Cannot use staged migration with an unknown model version 에러 발생

public typealias TeamV1 = LinableSchemaV1.Team
public typealias LineupV1 = LinableSchemaV1.Lineup
public typealias PlayerV1 = LinableSchemaV1.Player
public typealias TeamPlayerV1 = LinableSchemaV1.TeamPlayer

@MainActor
public let linableContainer: ModelContainer = {
    do {
        let schema = Schema([TeamV1.self, LineupV1.self, PlayerV1.self, TeamPlayerV1.self])
        let configuration = ModelConfiguration()
        let container = try ModelContainer(for: schema,
                                           configurations: [configuration])
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<TeamV1>()).isEmpty {
            let team = InitLinable.makeTheFirstTeam()
            container.mainContext.insert(team)
        }
        return container
    } catch {
        fatalError(error.localizedDescription)
    }
}()
