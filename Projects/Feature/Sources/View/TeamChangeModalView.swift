//
//  TeamChangeModalView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/12/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI
import Common

struct TeamChangeModalView: View {
    @ObservedObject var teamObservable: TeamObservable

    var body: some View {
        VStack {
            TeamList(teamObservable: teamObservable)
        }
        .presentationDetents([.height(334), .medium, .large])
        .presentationBackground(.regularMaterial)
    }
}

struct TeamList: View {
    @ObservedObject var teamObservable: TeamObservable

    var body: some View {
        ForEach(teamObservable.mockTeams, id: \.id) { team in
            VStack {
                HStack {
                    Image(asset: CommonAsset.uniform)
                        .resizable()
                        .opacity(teamObservable.currentTeam.id == team.id ? 1 : 0.4)
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 60)

                    VStack {
                        Text(team.teamName)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        Text("스쿼드 1개")
                            .font(.system(size: 10))
                    }
                }
            }
            .frame(width: 272, height: 62)
            .background(teamObservable.currentTeam.id == team.id ? Color.white : Color.white.opacity(0.6))
            .foregroundStyle(teamObservable.currentTeam.id == team.id ? Color.black : Color.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .onTapGesture {
                teamObservable.updateTeam(with: team)
            }
        }
    }
}
