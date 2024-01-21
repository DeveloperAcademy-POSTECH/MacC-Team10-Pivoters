//
//  LineupSchemaRepositoryInterface.swift
//  Domain
//
//  Created by 한지석 on 1/21/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public protocol LineupSchemaRepositoryInterface {
    var modelContext: ModelContext { get }

    func load(id: UUID) -> [Lineup]
    func update()
}
