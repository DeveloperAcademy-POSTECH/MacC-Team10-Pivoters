//
//  FetchLineupUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

import Core

public protocol FetchLineupUseCase {
    func excute(id: UUID) -> [Lineup]
}

public final class DefaultFetchLineupUseCase: FetchLineupUseCase {

    @Inject 
    private var repository: LineupSchemaRepositoryInterface

    public init() { }

    public func excute(id: UUID) -> [Lineup] {
        repository.load(id: id)
    }

}
