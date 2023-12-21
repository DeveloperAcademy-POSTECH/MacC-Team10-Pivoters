//
//  LinableMigrationPlan.swift
//  Core
//
//  Created by 한지석 on 12/12/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

enum LinableMigrationPlan: SchemaMigrationPlan {

    static var schemas: [VersionedSchema.Type] {
        [LinableSchemaV1.self, LinableSchemaV2.self]
    }


    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.custom(fromVersion: LinableSchemaV1.self, toVersion: LinableSchemaV2.self, willMigrate: nil) { context in
    }
}
