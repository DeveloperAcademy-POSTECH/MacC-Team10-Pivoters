//
//  PlayerSelectionObservable.swift
//  Presentation
//
//  Created by 박승찬 on 1/20/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

import Domain

@Observable
class PlayerSelectionObservable {
    var team: Team
    var members: [Player]
    var useCase: PlayerUseCase

    init(team: Team, members: [Player], useCase: PlayerUseCase) {
        self.team = team
        self.members = members
        self.useCase = useCase
    }

}
