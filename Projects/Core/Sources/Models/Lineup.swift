//
//  Lineup.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public final class Lineup {
    public let id: UUID
    public let uniform: Uniform
    public let headcount: Headcount
    public let players: [Player]

    public init(
        id: UUID,
        uniform: Uniform,
        headcount: Headcount,
        players: [Player]) {
            self.id = id
            self.uniform = uniform
            self.headcount = headcount
            self.players = players
        }
}

public enum Uniform: Codable {
    case basic
}

public enum Headcount: Int, Codable {
    case five = 5
    case six = 6
    case nine = 9
    case eleven = 11
}
