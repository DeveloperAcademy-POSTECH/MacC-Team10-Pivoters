//
//  Player.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

extension SchemaV1 {

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
