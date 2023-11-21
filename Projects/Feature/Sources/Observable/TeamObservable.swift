//
//  TeamObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/16/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

import Core

@Observable
class TeamObservable {

    var team: Team?
    var lineup: [Lineup] = [Lineup]()
    private let modelContext: ModelContext

    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTeam()
        team?.lineup.map { $0.selectionPlayerIndex = nil }
    }

    func fetchTeam() {
        do {
            var fetchDescriptor = FetchDescriptor<Team>()
            // MARK: 최신 생성 순을 보여지게 하기 위해 reverse
            fetchDescriptor.predicate = #Predicate {
                $0.isSelected
            }
            var teams = try modelContext.fetch(fetchDescriptor)
            // MARK: 선택 팀을 최상단에 보여지기 위함
            teams.sort { pre, _ in
                pre.isSelected
            }
            self.team = teams[0]
            self.lineup = teams[0].lineup.sorted { $0.index < $1.index }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
