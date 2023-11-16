//
//  TeamObservable.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

import Core

@Observable
class TeamSelectObservable {

    private let swiftDataManager: SwiftDataManager<RefactoredTeam>
    var modelContext: ModelContext
    var teams: [RefactoredTeam]

    var isCreatePresented: Bool = false
    var selectedTeam: String
    var currentPresentationDetent: PresentationDetent = .fraction(0.5)
    var presentationDetent: Set<PresentationDetent> = [.fraction(0.5)]

    @MainActor
    init(modelContext: ModelContext) {
        self.swiftDataManager = SwiftDataManager<RefactoredTeam>(modelContext: modelContext)
        self.modelContext = modelContext
        self.teams = swiftDataManager.fetchItem()
        if let selectedTeamUUID = UserDefaults.standard.string(forKey: "selectedTeamUUID") {
            self.selectedTeam = selectedTeamUUID
        } else {
            self.selectedTeam = ""
        }
    }

    func fetchTeam() -> [RefactoredTeam] {
        swiftDataManager.fetchItem()
    }

    func addTeam() {
        let randomInt = Int.random(in: 0...1111)
        let team = RefactoredTeam(id: UUID(),
                                  teamName: "\(randomInt)",
                                  subTitle: "how")
        swiftDataManager.insertItem(item: team)
        teams.append(team)
    }

    func moreButtonClicked() {
        presentationDetent.insert(.large)
        currentPresentationDetent = .large
    }

    func removeLargePresentationDetent() {
        presentationDetent.remove(.large)
    }

    func selectTeam(id: String) {
        self.selectedTeam = id
        UserDefaults.standard.setValue("selectedTeamUUID", forKey: id)
        self.teams.sort {
            if $0.id.uuidString == id {
                return true
            } else if $1.id.uuidString == id {
                return false
            } else {
                return false
            }
        }
    }
}
