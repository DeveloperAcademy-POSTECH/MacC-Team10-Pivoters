//
//  TeamDBRepositoryInterface.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public protocol TeamSchemaRepositoryInterface {
    var modelContext: ModelContext { get }

    func load() -> [Team]
    func saveName(name: String, id: UUID?)
}
