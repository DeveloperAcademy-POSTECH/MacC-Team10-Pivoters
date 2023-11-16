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
    @State var observable: TeamSelectObservable

    var body: some View {
        VStack(spacing: 0) {
            // MARK: 상단 X Button
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.colorLightGray)
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 16)
            .padding(.trailing, 16)

            Button {
                observable.moreButtonClicked()
            } label: {
                Text("더 보기")
                    .foregroundStyle(Color.colorBlack)
            }

            // MARK: 하단 List
            if observable.currentPresentationDetent == .fraction(0.5) {
                summaryTeamList
            } else {
                detailTeamList
            }
        }
        .background(.regularMaterial)
        .presentationDetents(observable.presentationDetent,
                             selection: $observable.currentPresentationDetent)
        .onChange(of: observable.currentPresentationDetent) {
            if observable.currentPresentationDetent == .fraction(0.5) {
                observable.removeLargePresentationDetent()
            }
        }
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $observable.isCreatePresented) {
            TeamCreateView()
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
        }
    }

    var summaryTeamList: some View {
        List {
            ForEach(observable.teams.prefix(3), id: \.id) { team in
                TeamCell(team: team,
                         cellType: .select,
                         isSelected: team.id.uuidString == observable.selectedTeam)
                .teamCellViewModifier()
                .onTapGesture {
                    observable.selectTeam(id: team.id.uuidString)
                    dismiss()
                }
            }
            TeamCell(team: nil,
                     cellType: .create,
                     isSelected: false)
            .teamCellViewModifier()
            .onTapGesture {
                observable.addTeam()
                //                observable.isCreatePresented.toggle()
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 60)
        .listStyle(.plain)
        .listRowSpacing(12)
        .background(.regularMaterial)
        .scrollContentBackground(.hidden)
    }

    var detailTeamList: some View {
        List {
            TeamCell(team: nil,
                     cellType: .create,
                     isSelected: false)
            .teamCellViewModifier()
            .onTapGesture {
                observable.addTeam()
                //                observable.isCreatePresented.toggle()
            }
            ForEach(observable.teams, id: \.id) { team in
                TeamCell(team: team,
                         cellType: .select,
                         isSelected: team.id.uuidString == observable.selectedTeam)
                .teamCellViewModifier()
                .onTapGesture {
                    observable.selectTeam(id: team.id.uuidString)
                    observable.removeLargePresentationDetent()
                    observable.currentPresentationDetent = .fraction(0.5)
                    dismiss()
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 60)
        .listStyle(.plain)
        .listRowSpacing(12)
        .background(.regularMaterial)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }

}
