//
//  TeamObservable.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import SwiftUI

class TeamObservable: ObservableObject {
    @Published var currentTeam: Team
    var mockTeams: [Team] = []

    init() {
        self.currentTeam = Team(id: UUID(), teamName: "Default Team", subTitle: "Default Subtitle", lineup: [])
        loadMockTeams()
        if let firstMockTeam = mockTeams.first {
            self.currentTeam = firstMockTeam
        }
    }

    func updateTeam(with team: Team) {
        currentTeam = team
    }

    func loadMockTeams() {
        let team1 = Team(id: UUID(), teamName: "울산현대 FC", subTitle: "2023 아시안 챔피언스리그 결승전 선발 멤버", lineup: [])
        let team2 = Team(id: UUID(), teamName: "첼시 FC", subTitle: "22/23 Season", lineup: [])
        let team3 = Team(id: UUID(), teamName: "토트넘 핫스퍼 FC", subTitle: "22/24 Season", lineup: [])

        mockTeams = [team1, team2, team3]
    }

}
