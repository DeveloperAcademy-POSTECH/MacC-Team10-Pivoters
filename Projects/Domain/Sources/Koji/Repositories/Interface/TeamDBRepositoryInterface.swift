//
//  TeamDBRepository.swift
//  Domain
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftData
import Combine

protocol TeamDBRepository {
    func load(modelContext: ModelContext) -> AnyPublisher<[SchemaV1.Team], Error>
}
