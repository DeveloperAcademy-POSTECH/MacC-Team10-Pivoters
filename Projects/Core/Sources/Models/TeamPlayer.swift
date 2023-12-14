//
//  Human.swift
//  Core
//
//  Created by 박승찬 on 11/21/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

extension LinableSchemaV1 {

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
