//
//  PlayerUseCase.swift
//  Domain
//
//  Created by 박승찬 on 1/20/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public protocol PlayerUseCase {
    func addPlayer(name: String, backNumber: Int)
}

public class PlayerSelectionUseCase: PlayerUseCase {
    private let teamDBRepository: TeamDBRepositoryInterface

    public init(teamDBRepository: TeamDBRepositoryInterface) {
        self.teamDBRepository = teamDBRepository
    }

    public func addPlayer(name: String, backNumber: Int) {
        teamDBRepository.addPlayer(player: Player(id: UUID(), name: name, backNumber: backNumber))
    }
}
