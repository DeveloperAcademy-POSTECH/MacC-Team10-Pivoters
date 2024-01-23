//
//  AppEnvironment.swift
//  App
//
//  Created by 한지석 on 1/22/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

import Core
import Data
import Domain

struct AppEnvironment {

    let container = DIContainer.shared
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        dependencyInjection()
    }

    func dependencyInjection() {
        registerRepositories()
        registerUseCases()
    }

    func registerUseCases() {
        // MARK: - Team UseCases
        container.register(type: FetchTeamUseCase.self, DefaultFetchTeamUseCase())
        container.register(type: SaveTeamUseCase.self, DefaultSaveTeamUseCase())

        // MARK: - Lineup UseCases
        container.register(type: FetchLineupUseCase.self, DefaultFetchLineupUseCase())
        container.register(type: UpdateLineupUseCase.self, DefaultUpdateLineupUseCase())
    }

    func registerRepositories() {
        // MARK: - Team Repository
        container.register(type: TeamSchemaRepositoryInterface.self,
                           TeamSchemaRepository(modelContext: modelContext))

        // MARK: - Lineup Repository
        container.register(type: LineupSchemaRepositoryInterface.self,
                           LineupSchemaRepository(modelContext: modelContext))
    }

}
