////
////  RefactoredTeamObservable.swift
////  Feature
////
////  Created by Eojin Choi on 11/15/23.
////  Copyright © 2023 com.pivoters. All rights reserved.
////
//
//import Foundation
//import SwiftData
//
//import Core
//
//@Observable
//class RefactoredTeamObservable {
//    
//    private var teams: [RefactoredTeam]?
//    private let swiftDataManeger: SwiftDataManager<RefactoredTeam>
//    var modelContext: ModelContext
//
//    @MainActor
//    init(modelContext: ModelContext) {
//        self.swiftDataManeger = SwiftDataManager<RefactoredTeam>(modelContext: modelContext)
//        self.modelContext = modelContext
//        self.teams = fetchTeam()
//    }
//    
//    func addTeam(team: RefactoredTeam) {
//        swiftDataManeger.insertItem(item: team)
//        self.teams = fetchTeam()
//    }
//    
//    func fetchTeam() -> [RefactoredTeam]? {
//        if let team: [RefactoredTeam] = swiftDataManeger.fetchItem() {
//            return team
//        } else {
//            return nil
//        }
//    }
//}
