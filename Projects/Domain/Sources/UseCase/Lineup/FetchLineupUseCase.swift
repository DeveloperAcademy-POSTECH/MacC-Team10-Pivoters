//
//  FetchLineupUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public protocol FetchLineupUseCase {
    func excute(id: UUID) -> [Lineup]
}

public final class DefaultFetchLineupUseCase: FetchLineupUseCase {

    private let repository: LineupSchemaRepositoryInterface

    private init(repository: LineupSchemaRepositoryInterface) {
        self.repository = repository
    }

    public func excute(id: UUID) -> [Lineup] {
        repository.load(id: id)
    }

}
