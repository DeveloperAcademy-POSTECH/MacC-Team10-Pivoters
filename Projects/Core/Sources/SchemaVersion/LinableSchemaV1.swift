//
//  TeamSchemaV1.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

public enum LinableSchemaV1: VersionedSchema {
    
    public static var versionIdentifier: Schema.Version = .init(1, 1, 0)
    public static var models: [any PersistentModel.Type] {
        [LinableSchemaV1.Team.self,
         LinableSchemaV1.Lineup.self,
         LinableSchemaV1.Player.self,
         LinableSchemaV1.TeamPlayer.self]
    }

}
