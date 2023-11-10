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
    public var uniform: Uniform
    public var headcount: Headcount
    public var players: [Player]
    public var primaryColor: UniformColor
    public var secondaryColor: UniformColor


    public init(
        id: UUID,
        uniform: Uniform,
        headcount: Headcount,
        players: [Player],
        primaryColor: UniformColor,
        secondaryColor: UniformColor) {
        self.id = id
        self.uniform = uniform
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

public enum Uniform: Codable {
    case basic
    case stripe
}

public enum Headcount: Int, Codable {
    case five = 5
    case six = 6
    case nine = 9
    case eleven = 11
}
