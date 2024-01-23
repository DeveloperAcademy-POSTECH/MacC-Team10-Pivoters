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

//    init() {
//        _ = AppEnvironment(modelContext: modelContainer.mainContext)
//    }

    var body: some Scene {
        WindowGroup {
            MainView(modelContext: linableContainer.mainContext)
                .modelContext(linableContainer.mainContext)
//            TempView()
        }
    }
}
