//
//  TeamSchemaV2.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public enum LinableSchemaV2: VersionedSchema {

    public static var versionIdentifier: Schema.Version = .init(1, 2, 0)
    public static var models: [any PersistentModel.Type] {
        []
    }
//    LinableSchemaV2.Team.self,
//     LinableSchemaV2.Lineup.self,
//     LinableSchemaV2.Player.self,
//     LinableSchemaV2.Human.self
}
