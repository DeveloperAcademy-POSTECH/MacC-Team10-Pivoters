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

class TeamCreateObservable {
    private let modelContext: ModelContext
    var teamName: String = ""

    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func createTeam() {
        guard self.teamName != "" else { return }
        let team = RefactoredTeam(id: UUID(),
                                  teamName: teamName,
                                  subTitle: "temp",
                                  isSelected: false,
                                  createdAt: Date(),
                                  updatedAt: Date())
        modelContext.insert(team)
    }
}
