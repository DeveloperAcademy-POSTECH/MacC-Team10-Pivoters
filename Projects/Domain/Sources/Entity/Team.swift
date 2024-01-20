//
//  Team.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public struct Team: Identifiable {
    public let id: UUID
    public var name: String
    public var members: [Player]

    public init(id: UUID, name: String, members: [Player]) {
        self.id = id
        self.name = name
        self.members = members
    }
}
