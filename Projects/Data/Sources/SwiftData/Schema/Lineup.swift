//
//  Lineup.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

extension SchemaV1 {

    @Model
    public final class Lineup {
        public let id: UUID
        public let index: Int
        public var lineupName: String
        public var selectedUniform: String
        public var selectedTheme: String
        public var selectedPlayType: Int
        public var selectedFormation: String
        public var primaryColor: UniformColor
        public var secondaryColor: UniformColor
        public var selectionPlayerIndex: Int?
        @Relationship(deleteRule: .cascade) public var players: [Player] = [Player]()
        public var trigger: Int?

        public init(id: UUID,
                    index: Int,
                    lineupName: String,
                    selectedUniform: String,
                    selectedTheme: String,
                    selectedPlayType: Int,
                    selectedFormation: String,
                    primaryColor: UniformColor,
                    secondaryColor: UniformColor,
                    selectionPlayerIndex: Int? = nil,
                    players: [Player],
                    trigger: Int? = nil) {
            self.id = id
            self.index = index
            self.lineupName = lineupName
            self.selectedUniform = selectedUniform
            self.selectedTheme = selectedTheme
            self.selectedPlayType = selectedPlayType
            self.selectedFormation = selectedFormation
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
            self.selectionPlayerIndex = selectionPlayerIndex
            self.players = players
            self.trigger = trigger
        }
    }

}
