//
//  SchemaV1.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public enum SchemaV1: VersionedSchema {

    public static var versionIdentifier: Schema.Version = .init(1, 1, 0)
    public static var models: [any PersistentModel.Type] {
        [SchemaV1.Team.self,
         SchemaV1.Lineup.self,
         SchemaV1.Player.self,
         SchemaV1.TeamPlayer.self]
    }

}
