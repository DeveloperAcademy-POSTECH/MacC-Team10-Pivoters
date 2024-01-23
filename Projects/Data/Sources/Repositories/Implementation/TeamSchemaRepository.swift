//
//  TeamDBRepository.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

import Domain

public struct TeamSchemaRepository: TeamSchemaRepositoryInterface {

    public var modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func load() -> [Team] {
        var fetchDescriptor = FetchDescriptor<SchemaV1.Team>()
        fetchDescriptor.sortBy = [SortDescriptor<SchemaV1.Team>(\.updatedAt, order: .reverse)]
        do {
            var team = try modelContext.fetch(fetchDescriptor)
            team.sort { pre, _ in
                pre.isSelected
            }
            return team.map {
                Team(
                    id: $0.id,
                    name: $0.teamName,
                    createdAt: $0.createdAt,
                    updatedAt: $0.updatedAt
                ) }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func saveName(name: String, id: UUID? = nil) {
        guard !name.isEmpty else { return }
        var team: SchemaV1.Team
        if let id = id {
            team = fetchTeam(id: id)
            team.teamName = name
        } else {
            team = InitData.makeTeam(teamName: name)
            modelContext.insert(team)
        }
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func fetchTeam(id: UUID) -> SchemaV1.Team {
        var fetchDescriptor = FetchDescriptor<SchemaV1.Team>()
        fetchDescriptor.predicate = #Predicate {
            $0.id == id
        }
        do {
            let team = try modelContext.fetch(fetchDescriptor)
            return team[0]
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}

enum SwiftDataError: Error {
    case nameIsEmpty
}
