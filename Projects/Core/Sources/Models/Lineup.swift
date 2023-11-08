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
    public var uniformType: UniformType
    public var headcount: Headcount
    public var players: [Player]
    public var primaryColor: UniformColor
    public var secondaryColor: UniformColor

    public init(
        id: UUID,
        uniformType: UniformType,
        headcount: Headcount,
        players: [Player],
        primaryColor: UniformColor,
        secondaryColor: UniformColor)
    {
        self.id = id
        self.uniformType = uniformType
        self.headcount = headcount
        self.players = players
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

public struct UniformColor {
    public var red: Double
    public var green: Double
    public var blue: Double

    public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

public enum UniformType: Int, Codable {
    case basic = 0
}

public enum Headcount: Int, Codable {
    case five = 5
    case six = 6
    case nine = 9
    case eleven = 11
}
