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
    public let subTitle: String
    public let lineup: [Lineup]

    public init(
        id: UUID,
        teamName: String,
        subTitle: String,
        lineup: [Lineup]) {
            self.id = id
            self.teamName = teamName
            self.subTitle = subTitle
            self.lineup = lineup
        }
}

