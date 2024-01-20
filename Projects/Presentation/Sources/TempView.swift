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

public struct TempView: View {

    var useCase: FetchTeamUseCase
    var team: [Team]

    public init(useCase: FetchTeamUseCase) {
        self.useCase = useCase
        self.team = useCase.excute()
    }

    public var body: some View {
        VStack {
            Button {
                print(team)
            } label: {
                Text("Temp Button")
            }
            PlayerSelectionView(observable: PlayerSelectionObservable(team: self.team[0], useCase: PlayerSelectionUseCase(teamDBRepository: useCase.getDB())))
        }
        .onAppear {
            print(team)
        }
    }
    
}
