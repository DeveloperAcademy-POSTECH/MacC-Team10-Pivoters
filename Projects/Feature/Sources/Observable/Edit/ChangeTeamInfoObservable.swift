//
//  ChangeTeamInfoObservable.swift
//  Feature
//
//  Created by 한지석 on 11/21/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import Combine

import Core


final class ChangeTeamInfoObservable: ObservableObject {
    let changeTeamInfo: ChangeTeamInfo
    var team: Team?
    var lineup: Lineup?
    @Published var name: String = ""
    @Published var isButtonEnabled = false

    var cancellables = Set<AnyCancellable>()

    private var validTextfieldPublisher: AnyPublisher<Bool, Never> {
        $name
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }

    init(changeTeamInfo: ChangeTeamInfo,
         name: String,
         team: Team? = nil,
         lineup: Lineup? = nil) {
        self.changeTeamInfo = changeTeamInfo
        self.name = name
        self.team = team
        self.lineup = lineup

        validTextfieldPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? true : false }
            .sink { self.isButtonEnabled = $0 }
            .store(in: &cancellables)
    }

    func changeName() {
        switch changeTeamInfo {
        case .team:
            self.team?.teamName = self.name
        case .squad:
            self.lineup?.lineupName = self.name
        }
    }

}
