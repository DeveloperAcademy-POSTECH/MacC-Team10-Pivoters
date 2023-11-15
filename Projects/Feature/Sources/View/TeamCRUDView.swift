//
//  TeamCRUDView.swift
//  Feature
//
//  Created by Eojin Choi on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import SwiftData
import SwiftUI

public struct TeamCRUDView: View {
    @Query private var teams: [RefactoredTeam]
    
    @Environment(\.modelContext) var context
    @State var observable: RefactoredTeamObservable
    
    @MainActor
    public init(modelcontext: ModelContext) {
        let observable = RefactoredTeamObservable(modelContext: modelcontext)
        _observable = State(initialValue: observable)
    }
    
    public var body: some View {
        VStack {
//            if let teams = observable.teams {
            List {
                ForEach(teams, id: \.self) { team in
                    Text(team.teamName)
                }
                .onDelete(perform: deleteItems)
                //                }
            }
            
            HStack {
                Button(action: {
                    observable.addTeam(team: RefactoredTeam(id: UUID(), teamName: "ho", subTitle: "naldo"))
                }, label: {
                    Text("추가")
                })
                .padding(.top, 10)
                
                Button(action: deleteLastItem) {
                    Text("마지막 삭제")
                }
                .padding(.top, 10)
            }
        }
    }
    
//    func addItem() {
//        var newTeam = Team(id: UUID(), teamName: "새 팀", subTitle: "새 서브 타이틀", lineup: [])
//        observable.insertTeam(team: newTeam)
//        observable.teams = observable.fetchTeams()
//    }
    
    func deleteLastItem() { }
    
    func deleteItems(at offsets: IndexSet) { }
}
