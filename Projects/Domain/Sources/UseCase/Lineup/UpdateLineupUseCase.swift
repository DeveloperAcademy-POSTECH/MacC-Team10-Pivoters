//
//  UpdateLineupUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/22/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

import Core

public protocol UpdateLineupUseCase {
    func excute(
        id: UUID,
        name: String
    )
}

public final class DefaultUpdateLineupUseCase: UpdateLineupUseCase {

    @Inject
    private var repository: LineupSchemaRepositoryInterface

    public init() { }

    public func excute(id: UUID, name: String) {
        repository
            .update(
                id: id,
                name: name
            )
    }

}
