//
//  SchemaV2.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftData

public enum SchemaV2: VersionedSchema {

    public static var versionIdentifier: Schema.Version = .init(1, 2, 0)
    public static var models: [any PersistentModel.Type] {
        []
    }
//    LinableSchemaV2.Team.self,
//     LinableSchemaV2.Lineup.self,
//     LinableSchemaV2.Player.self,
//     LinableSchemaV2.Human.self
}
