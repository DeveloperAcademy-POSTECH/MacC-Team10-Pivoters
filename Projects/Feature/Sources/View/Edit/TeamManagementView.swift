//
//  TeamManagementView.swift
//  Feature
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct TeamManagementView: View {

    @State var observable: TeamManagementObservable

    init(observable: TeamManagementObservable) {
        self.observable = observable
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(uiColor: .systemGray6))
                .frame(height: 54)
                .overlay {
                    formationPicker
                }
                .padding(.horizontal, 20)

            Button {
                observable.isChangeTeamInfoPresented.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text("팀 이름")
                                .font(.Pretendard.semiBold14.font)
                            Spacer()
                            HStack {
                                Text(observable.team.teamName)
                                    .font(.Pretendard.semiBold14.font)
                                    .tint(Color(uiColor: .lightGray))
                                Image(systemName: "chevron.right")
                                    .tint(Color(uiColor: .lightGray))
                            }
                        }
                        .padding(.horizontal, 12)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            Button {
                observable.isChangeLineupInfoPresented.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text("스쿼드 이름")
                                .font(.Pretendard.semiBold14.font)
                            Spacer()
                            HStack {
                                Text(observable.lineup.lineupName)
                                    .font(.Pretendard.semiBold14.font)
                                    .tint(Color(uiColor: .lightGray))
                                Image(systemName: "chevron.right")
                                    .tint(Color(uiColor: .lightGray))
                            }
                        }
                        .padding(.horizontal, 12)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            Spacer()
        }
        .sheet(isPresented: $observable.isChangeTeamInfoPresented) {
            ChangeTeamInfoView(observable: ChangeTeamInfoObservable(changeTeamInfo: .team,
                                                                    name: observable.team.teamName,
                                                                    team: observable.team),
                               changeTeamInfo: .team)
            .presentationDetents([.fraction(0.5)])
            .presentationBackground(.regularMaterial)
        }
        .sheet(isPresented: $observable.isChangeLineupInfoPresented) {
            ChangeTeamInfoView(observable: ChangeTeamInfoObservable(changeTeamInfo: .squad,
                                                                    name: observable.lineup.lineupName,
                                                                    lineup: observable.lineup),
                               changeTeamInfo: .squad)
            .presentationDetents([.fraction(0.5)])
            .presentationBackground(.regularMaterial)
        }
    }

    var formationPicker: some View {
        HStack {
            Text("포메이션")
                .font(.Pretendard.semiBold14.font)
                .tint(.colorBlack)
            Spacer()
            Picker("포메이션", selection: $observable.lineup.selectedTypeOfFormation) {
                ForEach(observable.lineup.formation.typeOfFormation, id: \.self) {
                    Text($0.rawValue)
                        .font(.Pretendard.black14.font)
                }
            }
            .foregroundColor(.colorBlack)
            .onChange(of: observable.lineup.selectedTypeOfFormation) { _, selectedFormation in
                observable.changeFormation(selectedFormation)
            }
            .tint(.gray)
            .pickerStyle(.menu)
        }
        .padding(.leading, 12)
    }
}