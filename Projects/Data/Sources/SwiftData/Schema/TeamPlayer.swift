//
//  TeamPlayer.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

extension SchemaV1 {

    @Model
    public final class TeamPlayer {
        public var id: UUID
        public var name: String
        public var backNumber: Int

        public init(id: UUID = UUID(), name: String, backNumber: Int) {
            self.id = id
            self.name = name
            self.backNumber = backNumber
        }
    }
}
