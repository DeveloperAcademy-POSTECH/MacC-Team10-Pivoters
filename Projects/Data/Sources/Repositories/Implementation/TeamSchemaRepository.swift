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

public struct TeamDBRepository: TeamDBRepositoryInterface {

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
            return team.map { Team(id: $0.id, name: $0.teamName) }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func save(name: String) {
        guard !name.isEmpty else { return }
        let team = InitData.makeTeam(teamName: name)
        do {
            modelContext.insert(team)
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

//    public func load() -> AnyPublisher<[SchemaV1.Team], Error> {
//        var fetchDescriptor = FetchDescriptor<SchemaV1.Team>()
//
//        return Future { promise in
//            do {
//                promise(
//                    .success(try modelContext.fetch(fetchDescriptor)
//                        .sorted { pre, _ in
//                            pre.isSelected
//                        }
//                    )
//                )
//            } catch {
//                promise(.failure(error))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//
//    public func save(name: String) -> AnyPublisher<Void, Error> {
//        return Future<Void, Error> { promise in
//            guard !name.isEmpty else {
//                promise(.failure(SwiftDataError.nameIsEmpty))
//                return
//            }
//            let team = InitData.makeTeam(teamName: name)
//            do {
//                modelContext.insert(team)
//                try modelContext.save()
//            } catch {
//                promise(.failure(error))
//            }
//
//        }
//        .eraseToAnyPublisher()
//    }

}

enum SwiftDataError: Error {
    case nameIsEmpty
}
