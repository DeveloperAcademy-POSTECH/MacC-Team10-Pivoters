//
//  Team.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

extension LinableSchemaV1 {

    @Model
    public final class Team {
        public let id: UUID
        public var teamName: String
        public var isSelected: Bool
        public let createdAt: Date
        public var updatedAt: Date
        @Relationship(deleteRule: .cascade) public var lineup: [Lineup]
        @Relationship(deleteRule: .cascade) public var teamPlayers: [TeamPlayer]

        public init(id: UUID,
                    teamName: String,
                    isSelected: Bool,
                    createdAt: Date,
                    updatedAt: Date,
                    lineup: [Lineup],
                    teamPlayers: [TeamPlayer]) {
            self.id = id
            self.teamName = teamName
            self.isSelected = isSelected
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.lineup = lineup
            self.teamPlayers = teamPlayers
        }
    }

}
