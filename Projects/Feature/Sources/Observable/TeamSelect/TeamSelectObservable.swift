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

    let modelContext: ModelContext
    var teams: [TeamV1] = []

    var isCreatePresented: Bool = false
    var currentPresentationDetent: PresentationDetent = .fraction(0.5)
    var presentationDetent: Set<PresentationDetent> = [.fraction(0.5)]

    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.teams = fetchTeam()
    }

    func fetchTeam() -> [TeamV1] {
        do {
            var fetchDescriptor = FetchDescriptor<TeamV1>()
            // MARK: 최신 생성 순을 보여지게 하기 위해 reverse
            fetchDescriptor.sortBy = [SortDescriptor<TeamV1>(\.updatedAt, order: .reverse)]
            var teams = try modelContext.fetch(fetchDescriptor)
            // MARK: 선택 팀을 최상단에 보여지기 위함
            teams.sort { pre, _ in
                pre.isSelected
            }
            return teams
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func moreButtonClicked() {
        presentationDetent.insert(.large)
        currentPresentationDetent = .large
    }

    func removeLargePresentationDetent() {
        presentationDetent.remove(.large)
    }

    func selectTeam(selectedTeam: TeamV1) {
        for team in teams {
            if team == selectedTeam {
                team.updatedAt = Date()
            }
            team.isSelected = selectedTeam == team
        }
        teams.sort { pre, _ in
            pre.isSelected
        }
    }
}
