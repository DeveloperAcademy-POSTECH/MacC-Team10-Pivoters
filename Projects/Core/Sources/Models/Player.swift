//
//  Player.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

extension LinableSchemaV1 {

    @Model
    public final class Player {
        public var id: UUID?
        public var number: Int
        public var isGoalkeeper: Bool
        public var offset: OffsetValue
        public var teamPlayer: TeamPlayer?

        public init(id: UUID? = nil,
                    number: Int,
                    isGoalkeeper: Bool,
                    offset: OffsetValue,
                    teamPlayer: TeamPlayer? = nil) {
            self.id = id
            self.number = number
            self.isGoalkeeper = isGoalkeeper
            self.offset = offset
            self.teamPlayer = teamPlayer
        }
    }

}
