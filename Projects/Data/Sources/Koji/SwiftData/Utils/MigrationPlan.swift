//
//  MigrationPlan.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftData

enum MigrationPlan: SchemaMigrationPlan {

    static var schemas: [VersionedSchema.Type] {
        [SchemaV1.self, SchemaV2.self]
    }


    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.custom(fromVersion: SchemaV1.self, toVersion: SchemaV2.self, willMigrate: nil) { context in
    }
}
