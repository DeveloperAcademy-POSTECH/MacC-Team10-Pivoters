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

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            TeamCRUDView(modelcontext: teamContainer.mainContext)
                .modelContainer(teamContainer)
        }
    }
}
