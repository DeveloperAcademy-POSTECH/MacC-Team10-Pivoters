//
//  Lineup.swift
//  Core
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

//@Model
//public final class Lineup {
//
//    public let id: UUID
//    public let index: Int
//    public var lineupName: String
//    public var uniform: Uniform
//    public var formation: Formation
//    public var selectedTypeOfFormation: TypeOfFormation // 선택된 포메이션이 저장되지 않고 있음.
//    public var primaryColor: UniformColor
//    public var secondaryColor: UniformColor
//    public var goalkeeperPrimaryColor: UniformColor
//    public var goalkeeperSecondaryColor: UniformColor
//    public var theme: Theme
//    public var selectionPlayerIndex: Int?
//    public var players: [Player] = [Player]()
//    public var trigger: Int?
//
//    public init(
//        id: UUID,
//        index: Int,
//        lineupName: String,
//        uniform: Uniform,
//        formation: Formation,
//        selectedTypeOfFormation: TypeOfFormation,
//        players: [Player],
//        primaryColor: UniformColor,
//        secondaryColor: UniformColor,
//        goalkeeperPrimaryColor: UniformColor,
//        goalkeeperSecondaryColor: UniformColor,
//        theme: Theme) {
//            self.id = id
//            self.index = index
//            self.lineupName = lineupName
//            self.uniform = uniform
//            self.formation = formation
//            self.selectedTypeOfFormation = selectedTypeOfFormation
//            self.players = players
//            self.primaryColor = primaryColor
//            self.secondaryColor = secondaryColor
//            self.goalkeeperPrimaryColor = goalkeeperPrimaryColor
//            self.goalkeeperSecondaryColor = goalkeeperSecondaryColor
//            self.theme = theme
//        }
//}

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

//public enum Uniform: Codable {
//    case plain
//    case stripe
////    case centerStripe
//}

