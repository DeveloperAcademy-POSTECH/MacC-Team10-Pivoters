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
                Text("팀 변경")
                    .font(.Pretendard.title.font)
                    .foregroundColor(.colorBlack)
                    .padding(.top, 8)
                Spacer()
                Button {
                    if observable.currentPresentationDetent == .large {
                        observable.currentPresentationDetent = .fraction(0.5)
                        observable.removeLargePresentationDetent()
                    }
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
            .padding(.horizontal, 16)

            if observable.currentPresentationDetent == .fraction(0.5) {
                HStack {
                    Spacer()
                    Button {
                        observable.moreButtonClicked()
                    } label: {
                        Text(String(localized: "Show More"))
                            .font(.Pretendard.semiBold14.font)
                            .foregroundStyle(Color.colorBlue)
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .padding(.trailing, 16)
                }
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
        // MARK: onChange의 성능상 문제 유발 가능성 있음
        /// 현재 로직
        /// 1. 팀 생성 뷰 사라지면 onChange
        /// 2. 사라졌을 때 패치
        /// 그러나 유저가 팀을 생성하지 않고 창을 없앨 가능성이 있음
        .onChange(of: observable.isCreatePresented) { _, newValue in
            if newValue == false {
                observable.teams = observable.fetchTeam()
            }
        }
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $observable.isCreatePresented) {
            TeamCreateView(observable: TeamCreateObservable(modelContext: observable.modelContext))
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
                .modelContainer(teamContainer)
        }
    }

    var summaryTeamList: some View {
        List {
            ForEach(observable.teams.prefix(3), id: \.id) { team in
                TeamCell(team: team,
                         cellType: .select,
                         isSelected: team.isSelected)
                .teamCellViewModifier()
                .onTapGesture {
                    observable.selectTeam(selectedTeam: team)
                    dismiss()
                }
            }
            TeamCell(team: nil,
                     cellType: .create,
                     isSelected: false)
            .teamCellViewModifier()
            .onTapGesture {
                observable.isCreatePresented.toggle()
            }
        }
        .padding(.top, 12)
        .padding(.horizontal, 60)
        .listStyle(.plain)
        .listRowSpacing(12)
        .background(.regularMaterial)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }

    var detailTeamList: some View {
        List {
            TeamCell(team: nil,
                     cellType: .create,
                     isSelected: false)
            .teamCellViewModifier()
            .onTapGesture {
                observable.isCreatePresented.toggle()
            }
            ForEach(observable.teams, id: \.id) { team in
                TeamCell(team: team,
                         cellType: .select,
                         isSelected: team.isSelected)
                .teamCellViewModifier()
                .onTapGesture {
                    observable.selectTeam(selectedTeam: team)
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
