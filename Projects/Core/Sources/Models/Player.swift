//
//  Player.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public final class Player: Identifiable {
    public let name: String
    public let number: Int
    public let isGoalkeeper: Bool
    public var offset: OffsetValue = OffsetValue()

    public init(name: String, number: Int, isGoalkeeper: Bool) {
        self.name = name
        self.number = number
        self.isGoalkeeper = isGoalkeeper
    }
}

