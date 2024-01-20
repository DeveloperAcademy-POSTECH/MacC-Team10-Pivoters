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
    func getDB() -> TeamDBRepositoryInterface
}

public final class DefaultFetchTeamUseCase: FetchTeamUseCase {

    public let teamDBRepository: TeamDBRepositoryInterface

    public init(teamDBRepository: TeamDBRepositoryInterface) {
        self.teamDBRepository = teamDBRepository
    }

    public func excute() -> [Team] {
        teamDBRepository.load()
    }

    public func getDB() -> TeamDBRepositoryInterface{
        return self.teamDBRepository
    }
}
