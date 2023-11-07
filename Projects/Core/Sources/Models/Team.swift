//
//  Team.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public final class Team {
    public let id: UUID
    public let teamName: String
    public let subTeamName: String
    public let lineup: [Lineup]

    public init(
        id: UUID,
        teamName: String,
        subTeamName: String,
        lineup: [Lineup]) {
            self.id = id
            self.teamName = teamName
            self.subTeamName = subTeamName
            self.lineup = lineup
        }
}

