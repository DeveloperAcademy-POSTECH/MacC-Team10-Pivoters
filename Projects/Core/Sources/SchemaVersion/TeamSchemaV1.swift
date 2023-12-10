//
//  TeamSchemaV1.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public enum TeamSchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version = .init(1, 0, 0)
    public static var models: [any PersistentModel.Type] {
        [Team.self, Lineup.self]
    }

    @Model
    public final class Team {
        public let id: UUID
        public var teamName: String
        public var isSelected: Bool
        public let createdAt: Date
        public var updatedAt: Date
        public var lineup: [Lineup]
        public var teamMembers: [Human]

        public init(id: UUID,
                    teamName: String,
                    isSelected: Bool,
                    createdAt: Date,
                    updatedAt: Date,
                    lineup: [Lineup],
                    addedPlayers: [Human]) {
            self.id = id
            self.teamName = teamName
            self.isSelected = isSelected
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.lineup = lineup
            self.teamMembers = addedPlayers
        }
    }

    @Model
    public final class Lineup {

        public let id: UUID
        public let index: Int
        public var lineupName: String
        public var uniform: Uniform
        public var formation: Formation
        public var selectedTypeOfFormation: TypeOfFormation // 선택된 포메이션이 저장되지 않고 있음.
        public var primaryColor: UniformColor
        public var secondaryColor: UniformColor
        public var goalkeeperPrimaryColor: UniformColor
        public var goalkeeperSecondaryColor: UniformColor
        public var theme: Theme
        public var selectionPlayerIndex: Int?
        public var players: [Player] = [Player]()
        public var trigger: Int?

        public init(
            id: UUID,
            index: Int,
            lineupName: String,
            uniform: Uniform,
            formation: Formation,
            selectedTypeOfFormation: TypeOfFormation,
            players: [Player],
            primaryColor: UniformColor,
            secondaryColor: UniformColor,
            goalkeeperPrimaryColor: UniformColor,
            goalkeeperSecondaryColor: UniformColor,
            theme: Theme) {
                self.id = id
                self.index = index
                self.lineupName = lineupName
                self.uniform = uniform
                self.formation = formation
                self.selectedTypeOfFormation = selectedTypeOfFormation
                self.players = players
                self.primaryColor = primaryColor
                self.secondaryColor = secondaryColor
                self.goalkeeperPrimaryColor = goalkeeperPrimaryColor
                self.goalkeeperSecondaryColor = goalkeeperSecondaryColor
                self.theme = theme
            }
    }
}
