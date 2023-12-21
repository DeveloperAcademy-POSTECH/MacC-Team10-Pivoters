//
//  AddPlayerObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/29/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import Combine
import SwiftData

import Core

class AddPlayerObservable: ObservableObject {

    @Published var playerName: String
    @Published var isButtonEnabled: Bool
    var team: Team
    var teamPlayer: TeamPlayer?
    let addPlayerInfo: AddPlayerInfo
    private let modelContext: ModelContext

    var cancellables = Set<AnyCancellable>()

    private var validTextfieldPublisher: AnyPublisher<Bool, Never> {
        $playerName
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }

    @MainActor
    init(
        playerName: String = "",
        isButtonEnabled: Bool = false,
        team: Team,
        teamPlayer: TeamPlayer? = nil,
        addPlayerInfo: AddPlayerInfo
    ) {
            self.playerName = playerName
            self.isButtonEnabled = isButtonEnabled
            self.team = team
            self.teamPlayer = teamPlayer
            self.addPlayerInfo = addPlayerInfo
            self.modelContext = linableContainer.mainContext

            validTextfieldPublisher
                .receive(on: RunLoop.main)
                .map { $0 ? true : false }
                .sink { self.isButtonEnabled = $0 }
                .store(in: &cancellables)
        }

    func addPlayer() {
        switch addPlayerInfo {
        case .add:
            team.teamPlayers.insert(InitLinable.makeTeamPlayer(name: playerName,
                                                           backNumber: 1),
                                at: 0)
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
        case .edit:
            self.teamPlayer?.name = self.playerName
        }
    }
}
