//
//  SaveTeamUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public protocol SaveTeamUseCase {
    func excute(
        name: String,
        id: UUID?
    )
}

public final class DefaultSaveTeamUseCase: SaveTeamUseCase {

    private let teamSchemaRepository: TeamSchemaRepositoryInterface

    public init(teamSchemaRepository: TeamSchemaRepositoryInterface) {
        self.teamSchemaRepository = teamSchemaRepository
    }

    public func excute(name: String, id: UUID?) {
        teamSchemaRepository.saveName(
            name: name,
            id: id
        )
    }

}
