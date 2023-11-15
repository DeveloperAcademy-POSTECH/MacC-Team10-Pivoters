//
//  TeamObservable.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

import Core

@Observable
class TeamSelectObservable {

    var isCreatePresented: Bool = false
    var teams: [Team]
    var selectedTeam: String
    var currentPresentationDetent: PresentationDetent = .fraction(0.5)
    var presentationDetent: Set<PresentationDetent> = [.fraction(0.5)]

    init(teams: [Team] = MockData.teams) {
        self.teams = teams
        if let selectedTeamUUID = UserDefaults.standard.string(forKey: "selectedTeamUUID") {
            self.selectedTeam = selectedTeamUUID
        } else {
            self.selectedTeam = teams[0].id.uuidString
        }
    }

    func addTeam() {

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
