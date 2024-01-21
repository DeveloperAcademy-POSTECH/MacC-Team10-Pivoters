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
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    //    public func load() -> [Team] {
    //        var fetchDescriptor = FetchDescriptor<SchemaV1.Team>()
    //        fetchDescriptor.sortBy = [SortDescriptor<SchemaV1.Team>(\.updatedAt, order: .reverse)]
    //        do {
    //            var team = try modelContext.fetch(fetchDescriptor)
    //            team.sort { pre, _ in
    //                pre.isSelected
    //            }
    //            return team.map {
    //                Team(
    //                    id: $0.id,
    //                    name: $0.teamName,
    //                    createdAt: $0.createdAt,
    //                    updatedAt: $0.updatedAt
    //                ) }
    //        } catch {
    //            fatalError(error.localizedDescription)
    //        }
    //    }

}
