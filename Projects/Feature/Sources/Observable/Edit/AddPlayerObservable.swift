//
//  AddPlayerObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/29/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import Combine

import Core

class AddPlayerObservable: ObservableObject {
    @Published var playerName: String
    @Published var isButtonEnabled: Bool
    var team: Team

    var cancellables = Set<AnyCancellable>()

    private var validTextfieldPublisher: AnyPublisher<Bool, Never> {
        $playerName
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }

    init(playerName: String = "", isButtonEnabled: Bool = false, team: Team) {
        self.playerName = playerName
        self.isButtonEnabled = isButtonEnabled
        self.team = team

        validTextfieldPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? true : false }
            .sink { self.isButtonEnabled = $0 }
            .store(in: &cancellables)
    }

    func addPlayer() {
        team.teamMembers.insert(InitTeamContainer.makeHuman(name: playerName,
                                                            backNumber: 1),
                                at: 0)
    }
}
