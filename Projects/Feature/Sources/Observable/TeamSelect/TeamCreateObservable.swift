//
//  TeamCreateObservable.swift
//  Feature
//
//  Created by 한지석 on 11/16/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Combine
import Foundation
import SwiftData

import Core

class TeamCreateObservable: ObservableObject {

    private let modelContext: ModelContext
    @Published var teamName: String = ""
    @Published var isButtonEnabled = false

    var cancellables = Set<AnyCancellable>()

    private var validTextfieldPublisher: AnyPublisher<Bool, Never> {
        $teamName
            .map {
                $0.count > 0
            }
            .eraseToAnyPublisher()
    }

    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext

        validTextfieldPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? true : false }
            .assign(to: \.isButtonEnabled, on: self)
            .store(in: &cancellables)
    }

    func createTeam() {
        guard self.teamName != "" else { return }
        let team = InitTeamContainer.makeTeam(teamName: self.teamName)
        modelContext.insert(team)
    }
}
