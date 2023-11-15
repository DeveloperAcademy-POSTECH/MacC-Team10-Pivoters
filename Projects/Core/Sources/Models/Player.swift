//
//  Player.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@Observable
public final class Player: Identifiable {
    public var id: UUID?
    public var name: String
    public var number: Int
    public var isGoalkeeper: Bool
    public var offset: OffsetValue

    public init(id: UUID? = nil, name: String, number: Int, isGoalkeeper: Bool, offset: OffsetValue) {
        self.id = id
        self.name = name
        self.number = number
        self.isGoalkeeper = isGoalkeeper
        self.offset = offset
    }
}
