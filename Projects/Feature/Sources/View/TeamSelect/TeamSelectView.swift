//
//  TeamChangeModalView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/12/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Core
import Common

struct TeamSelectView: View {

    @Environment(\.dismiss) var dismiss
    @State var observable: TeamObservable

    var body: some View {
        VStack(spacing: 0) {
            // MARK: 상단 Dismiss
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .renderingMode(.template)
                        .foregroundStyle(Color.colorLightGray)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
            // MARK: 하단 List
            teamList
        }
        .background(.regularMaterial)
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $observable.isPresented) {
            TeamCreateView()
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
        }
    }

    var teamList: some View {
        List {
            ForEach(observable.teams, id: \.id) { team in
                TeamCell(team: team,
                         cellType: .select,
                         isSelected: team.id.uuidString == observable.selectedTeam)
                .teamCellViewModifier()
                .onTapGesture {
                    print(team.id)
                }
            }
            TeamCell(team: nil,
                     cellType: .add,
                     isSelected: false)
            .teamCellViewModifier()
            .onTapGesture {
                observable.isPresented.toggle()
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 60)
        .listStyle(.plain)
        .listRowSpacing(12)
        .background(.regularMaterial)
        .scrollContentBackground(.hidden)
    }

}
