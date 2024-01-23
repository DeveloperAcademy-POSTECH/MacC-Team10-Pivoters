//
//  FetchTeamUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/19/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

import Core

public protocol FetchTeamUseCase {
    func excute() -> [Team]
}

public final class DefaultFetchTeamUseCase: FetchTeamUseCase {

    @Inject 
    private var repository: TeamSchemaRepositoryInterface

    public init() { }

    public func excute() -> [Team] {
        repository.load()
    }
}
