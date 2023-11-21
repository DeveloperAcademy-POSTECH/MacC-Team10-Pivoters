//
//  TeamCreateObservable.swift
//  Feature
//
//  Created by 한지석 on 11/16/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

import Core

@Observable
class TeamCreateObservable {
    private let modelContext: ModelContext
    var teamName: String = ""

    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func createTeam() {
        guard self.teamName != "" else { return }
        let team = InitTeamContainer.makeTeam(teamName: self.teamName)
        modelContext.insert(team)
    }
}
