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

    @State var observable: TeamSelectObservable

    @MainActor
    public init(modelcontext: ModelContext) {
        let observable = TeamSelectObservable(modelContext: modelcontext)
        _observable = State(initialValue: observable)
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(teams, id: \.self) { team in
                        NavigationLink(destination: LineupCRUDView(team: team)) {
                            Text(team.teamName)
                        }
                    }
                    .onDelete(perform: deleteTeam)
                }
            }
            HStack {
                Button(action: {
                    context.insert(
                        RefactoredTeam(
                            id: UUID(),
                            teamName: "새 팀 " + String(teams.count + 1),
                            subTitle: "naldo",
                            isSelected: true,
                            lineups: [
                                RefactoredLineup(
                                    id: UUID(),
                                    lineupName: "새 라인업 1",
                                    uniform: .stripe,
                                    formation: .eleven,
                                    primaryColor: UniformColor(red: 0.3, green: 0.6, blue: 0.45),
                                    secondaryColor: UniformColor(red: 0.8, green: 0.8, blue: 0.8)),
                                RefactoredLineup(
                                    id: UUID(),
                                    lineupName: "새 라인업 2",
                                    uniform: .stripe,
                                    formation: .eleven,
                                    primaryColor: UniformColor(red: 0.3, green: 0.6, blue: 0.45),
                                    secondaryColor: UniformColor(red: 0.8, green: 0.8, blue: 0.8)),
                                RefactoredLineup(
                                    id: UUID(),
                                    lineupName: "새 라인업 3",
                                    uniform: .stripe,
                                    formation: .eleven,
                                    primaryColor: UniformColor(red: 0.3, green: 0.6, blue: 0.45),
                                    secondaryColor: UniformColor(red: 0.8, green: 0.8, blue: 0.8)),
                            ],
                            createdAt: Date(),
                            updatedAt: Date()))
                }, label: {
                    Text("팀 추가")
                })
                .padding(.top, 10)
            }
        }
    }

    func deleteTeam(at offsets: IndexSet) {
        for index in offsets {
            let teamToDelete = teams[index]
            context.delete(teamToDelete)
        }
    }

}
