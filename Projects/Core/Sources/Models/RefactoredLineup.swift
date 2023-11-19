//
//  RefactoredLineup.swift
//  Core
//
//  Created by Eojin Choi on 11/17/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@Model
public final class RefactoredLineup {
    public let id: UUID
    public var lineupName: String
    public var uniform: Uniform
    public var formation: Formation
//    public var selectedTypeOfFormation: TypeOfFormation
//    public var players: [Player]
    public var primaryColor: UniformColor
    public var secondaryColor: UniformColor

    public init(
        id: UUID,
        lineupName: String,
        uniform: Uniform,
        formation: Formation,
//        selectedTypeOfFormation: TypeOfFormation,
//        players: [Player],
        primaryColor: UniformColor,
        secondaryColor: UniformColor) {
            self.id = id
            self.lineupName = lineupName
            self.uniform = uniform
            self.formation = formation
//            self.selectedTypeOfFormation = selectedTypeOfFormation
//            self.players = players
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
        }
}

//public struct UniformColor: Codable {
//    public var red: Double
//    public var green: Double
//    public var blue: Double
//
//    public init(red: Double, green: Double, blue: Double) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//    }
//}

//public enum Uniform: Codable {
//    case plain
//    case stripe
//}

//public enum Theme: Codable {
//    case blueGray
//    case whiteGreen
//    case blackBlue
//    case grayBlack
//}

