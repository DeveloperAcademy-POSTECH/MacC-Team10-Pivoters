//
//  TeamDBRepositoryInterface.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftData
import Combine

public protocol TeamDBRepositoryInterface {

    var modelContext: ModelContext { get }

    func load() -> AnyPublisher<[SchemaV1.Team], Error>
}
