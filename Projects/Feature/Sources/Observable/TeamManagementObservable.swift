//
//  TeamManagementObservable.swift
//  Feature
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
final class TeamManagementObservable {
    var lineup: Lineup
    var selectedTypeOfFormation: TypeOfFormation

    init(lineup: Lineup) {
        self.lineup = lineup
        self.selectedTypeOfFormation = lineup.selectedTypeOfFormation
    }
}
