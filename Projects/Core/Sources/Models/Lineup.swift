//
//  Lineup.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@Observable
public final class Lineup {

    public let id: UUID
    public var uniform: Uniform
    public var formation: Formation
    public var selectedTypeOfFormation: TypeOfFormation
    public var players: [Player]
    public var primaryColor: UniformColor
    public var secondaryColor: UniformColor

    public init(
        id: UUID,
        uniform: Uniform,
        formation: Formation,
        selectedTypeOfFormation: TypeOfFormation,
        players: [Player],
        primaryColor: UniformColor,
        secondaryColor: UniformColor) {
            self.id = id
            self.uniform = uniform
            self.formation = formation
            self.selectedTypeOfFormation = selectedTypeOfFormation
            self.players = players
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
        }
}

public struct UniformColor: Codable {
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
    case plain
    case stripe
}

public enum Theme: Codable {
    case blueGray
    case whiteGreen
    case blackBlue
    case grayBlack
}
