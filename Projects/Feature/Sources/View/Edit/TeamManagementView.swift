//
//  TeamManagementView.swift
//  Feature
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

struct TeamManagementView: View {

    @State var observable: TeamManagementObservable

    init(observable: TeamManagementObservable) {
        self.observable = observable
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(uiColor: .systemGray5))
                .frame(height: 54)
                .overlay {
                    playerPicker
                }
                .padding(.horizontal, 20)

            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(uiColor: .systemGray5))
                .frame(height: 54)
                .overlay {
                    formationPicker
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)

            NavigationLink {
                ChangeTeamInfoView(observable: ChangeTeamInfoObservable(changeTeamInfo: .team,
                                                                        name: observable.team.teamName,
                                                                        team: observable.team),
                                   changeTeamInfo: .team)
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text(String(localized: "Team Name"))
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

            NavigationLink {
                ChangeTeamInfoView(observable: ChangeTeamInfoObservable(changeTeamInfo: .squad,
                                                                        name: observable.lineup.lineupName,
                                                                        lineup: observable.lineup),
                                   changeTeamInfo: .squad)
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text(String(localized: "Lineup Name"))
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
    }

    var playerPicker: some View {
        HStack {
            Text(String(localized: "Number of Players"))
                .font(.Pretendard.semiBold14.font)
                .tint(.colorBlack)
            Spacer()
            Picker(String(localized: "Number of Players"), selection: $observable.lineup.selectedPlayType) {
                ForEach(PlayType.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                        .tag($0.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .foregroundColor(.colorBlack)
            .onChange(of: observable.lineup.selectedPlayType) { _, newPlayerNumber in
                observable.changePlayerNumber(newPlayerNumber)
            }
            .tint(.gray)
        }
        .padding(.leading, 12)
    }

    var formationPicker: some View {
        HStack {
            Text(String(localized: "Formation"))
                .font(.Pretendard.semiBold14.font)
                .tint(.colorBlack)
            Spacer()
            Picker(String(localized: "포메이션"), selection: $observable.lineup.selectedFormation) {
                ForEach(PlayType(rawValue: observable.lineup.selectedPlayType)?.typeOfFormation ?? 
                        [.football442, .football433],
                        id: \.self) {
                    Text($0.rawValue)
                        .tag($0.rawValue)
                }
            }
            .foregroundColor(.colorBlack)
            .onChange(of: observable.lineup.selectedFormation) { _, selectedFormation in
                observable.changeFormation(Formation(rawValue: selectedFormation) ?? Formation.football433)
            }
            .tint(.gray)
            .pickerStyle(.menu)
        }
        .padding(.leading, 12)
    }
}
