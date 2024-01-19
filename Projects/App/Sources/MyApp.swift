//
//  MyApp.swift
//  App
//
//  Created by Ha Jong Myeong on 10/7/23.
//

import Core
import Feature
import SwiftData
import SwiftUI

import Presentation
import Data
import Domain

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(modelContext: modelContainer.mainContext)
                .modelContext(modelContainer.mainContext)
//            TempView(useCase: DefaultFetchTeamUseCase(teamDBRepository: TeamDBRepository(modelContext: modelContainer.mainContext)))
//                .modelContext(modelContainer.mainContext)
        }
    }
}
