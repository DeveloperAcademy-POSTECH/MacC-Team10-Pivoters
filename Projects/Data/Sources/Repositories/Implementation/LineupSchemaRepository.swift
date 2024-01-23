//
//  LineupSchemaRepository.swift
//  Data
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

import Domain

public final class LineupSchemaRepository: LineupSchemaRepositoryInterface {

    public var modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func load(id: UUID) -> [Lineup] {
        var fetchDescriptor = FetchDescriptor<SchemaV1.Team>()
        fetchDescriptor.predicate = #Predicate {
            $0.id == id
        }
        do {
            let team = try modelContext.fetch(fetchDescriptor)
            return team[0].lineup.map {
                Lineup(
                    id: $0.id,
                    index: $0.index,
                    name: $0.lineupName,
                    playerIndex: $0.selectionPlayerIndex
                )
            }.sorted { $0.index < $1.index }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func update(id: UUID, name: String) {
        var lineup = fetchLineup(id: id)
        lineup.lineupName = name
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func fetchLineup(id: UUID) -> SchemaV1.Lineup {
        var fetchDescriptor = FetchDescriptor<SchemaV1.Lineup>()
        fetchDescriptor.predicate = #Predicate {
            $0.id == id
        }
        do {
            let lineup = try modelContext.fetch(fetchDescriptor)
            return lineup[0]
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
