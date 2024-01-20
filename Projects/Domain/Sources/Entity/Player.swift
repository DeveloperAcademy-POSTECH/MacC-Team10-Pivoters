//
//  Player.swift
//  Domain
//
//  Created by 박승찬 on 1/20/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public struct Player: Identifiable {
    public let id: UUID
    public var name: String
    public var backNumber: Int
    
    public init(id: UUID, name: String, backNumber: Int) {
        self.id = id
        self.name = name
        self.backNumber = backNumber
    }
}
