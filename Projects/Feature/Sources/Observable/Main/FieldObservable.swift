//
//  FieldObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import Foundation

@Observable
class FieldObservable {

    var team: Team
    var lineup: Lineup

    init(team: Team, lineup: Lineup) {
        self.team = team
        self.lineup = lineup
    }
}
