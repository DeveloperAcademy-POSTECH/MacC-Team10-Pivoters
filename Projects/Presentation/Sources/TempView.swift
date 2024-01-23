//
//  TempView.swift
//  Presentation
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import SwiftUI
import SwiftData

import Domain
import Core

public struct TempView: View {

    @State var team: [Team]
    @State var lineup: [Lineup]

    var fetchTeamUseCase: FetchTeamUseCase = DIContainer.shared.resolve(type: FetchTeamUseCase.self)
    var saveTeamUseCase: SaveTeamUseCase = DIContainer.shared.resolve(type: SaveTeamUseCase.self)
    var fetchLineupUseCase: FetchLineupUseCase = DIContainer.shared.resolve(type: FetchLineupUseCase.self)
    var updateLineupUseCase: UpdateLineupUseCase = DIContainer.shared.resolve(type: UpdateLineupUseCase.self)

    public init() {
        let team = fetchTeamUseCase.excute()
        self._team = .init(initialValue: team)
        self._lineup = .init(initialValue: fetchLineupUseCase.excute(id: team[0].id))
    }

    public var body: some View {
        VStack {
            Button {
                lineup = fetchLineupUseCase.excute(id: team[0].id)
                lineup.forEach {
                    print($0)
                }
            } label: {
                Text("LINEUP FETCH")
            }
            Button {
                updateLineupUseCase.excute(id: lineup[0].id, name: "임꺽정")
            } label: {
                Text("LINEUP UPDATE")
            }
            Button {
                saveTeamUseCase.excute(name: "호날두", id: team[0].id)
            } label: {
                Text("TEAM SAVE")
            }
            Button {
                team = fetchTeamUseCase.excute()
                team.forEach { print($0.name) }
            } label: {
                Text("TEAM FETCH")
            }
        }
    }

}
