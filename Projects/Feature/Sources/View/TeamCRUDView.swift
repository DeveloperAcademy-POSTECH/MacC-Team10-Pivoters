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

struct TeamCRUDView: View {
    @Query private var teams: [Team]
    
    @Environment(\.modelContext) var context
    @Bindable var observable: RefactoredTeamObservable
    
    @MainActor
    public init(modelcontext: ModelContext) {
        self.observable = RefactoredTeamObservable(modelContext: modelcontext)
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
                Button(action: addItem) {
                    Text("추가")
                }
                .padding(.top, 10)
                
                Button(action: deleteLastItem) {
                    Text("마지막 삭제")
                }
                .padding(.top, 10)
            }
        }
    }
    
    func addItem() {
        var newTeam = Team(id: UUID(), teamName: "새 팀", subTitle: "새 서브 타이틀", lineup: [])
        observable.insertTeam(team: newTeam)
        observable.teams = observable.fetchTeams()
    }
    
    func deleteLastItem() { }
    
    func deleteItems(at offsets: IndexSet) { }
}
