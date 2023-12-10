//
//  LineupCRUDView.swift
//  Feature
//
//  Created by Eojin Choi on 11/17/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import SwiftData
import SwiftUI
//
//public struct LineupCRUDView: View {
//    var team: RefactoredTeam
//
//    @Environment(\.modelContext) var context
//
//    public var body: some View {
//        VStack {
//            List {
//                ForEach(team.lineups, id: \.self) { lineup in
//                    Text(lineup.lineupName)
//                }
//                .onDelete(perform: deleteLineup)
//            }
//
//            HStack {
//                Button(action: {
//                }, label: {
//                    Text(String(localized: "Add Lineup"))
//                })
//                .padding(.top, 10)
//            }
//        }
//    }
//
//    func deleteLineup(at offsets: IndexSet) {
//        do {
//            for index in offsets {
//                let teamToDelete = team.lineups[index]
//                //            context.delete(teamToDelete)
//            }
//            team.lineups.remove(atOffsets: offsets)
//
//            try context.save()
//        } catch {
//            print("error")
//        }
//    }
//}
