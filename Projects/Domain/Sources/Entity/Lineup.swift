//
//  Lineup.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public struct Lineup: Identifiable {
    public let id: UUID
    public let index: Int
    public var name: String
    public var playerIndex: Int?

    public init(
        id: UUID,
        index: Int,
        name: String,
        playerIndex: Int? = nil
    ) {
        self.id = id
        self.index = index
        self.name = name
        self.playerIndex = playerIndex
    }
}
