//
//  TeamDBRepositoryInterface.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftData

public protocol TeamDBRepositoryInterface {
    var modelContext: ModelContext { get }

    func load() -> [Team]
    func save(name: String)
}
