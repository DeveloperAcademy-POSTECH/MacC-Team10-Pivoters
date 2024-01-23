//
//  SaveTeamUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

import Core

public protocol SaveTeamUseCase {
    func excute(
        name: String,
        id: UUID?
    )
}

public final class DefaultSaveTeamUseCase: SaveTeamUseCase {

    @Inject 
    private var repository: TeamSchemaRepositoryInterface

    public init() { }

    public func excute(name: String, id: UUID?) {
        repository.saveName(
            name: name,
            id: id
        )
    }

}
