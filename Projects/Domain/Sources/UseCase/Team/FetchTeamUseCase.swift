//
//  FetchTeamUseCase.swift
//  Domain
//
//  Created by 한지석 on 1/19/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public protocol FetchTeamUseCase {
    func excute() -> [Team]
}

public final class DefaultFetchTeamUseCase: FetchTeamUseCase {

    private let teamSchemaRepository: TeamSchemaRepositoryInterface

    public init(teamSchemaRepository: TeamSchemaRepositoryInterface) {
        self.teamSchemaRepository = teamSchemaRepository
    }

    public func excute() -> [Team] {
        teamSchemaRepository.load()
    }
}
