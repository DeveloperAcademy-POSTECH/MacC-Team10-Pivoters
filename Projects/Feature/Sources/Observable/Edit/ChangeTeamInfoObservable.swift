//
//  ChangeTeamInfoObservable.swift
//  Feature
//
//  Created by 한지석 on 11/21/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
final class ChangeTeamInfoObservable {
    let changeTeamInfo: ChangeTeamInfo
    var name: String
    var team: Team?
    var lineup: Lineup?

    init(changeTeamInfo: ChangeTeamInfo,
         name: String,
         team: Team? = nil,
         lineup: Lineup? = nil) {
        self.changeTeamInfo = changeTeamInfo
        self.name = name
        self.team = team
        self.lineup = lineup
    }

    func changeName() {
        switch changeTeamInfo {
        case .team:
            self.team?.teamName = self.name
        case .squad:
            self.lineup?.lineupName = self.name
        }
    }

}
