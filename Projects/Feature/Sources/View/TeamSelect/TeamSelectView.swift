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
    @State var observable: TeamObservable

    var body: some View {
        VStack {
            teamList
        }
        .presentationDetents([.fraction(0.5)])
        .presentationBackground(.regularMaterial)
    }

    var teamList: some View {
        List {
            ForEach(observable.teams, id: \.id) { team in
                TeamCell(team: team, cellType: .select)
                    .teamCellViewModifier()
                    .onTapGesture {
                    }
            }
            TeamCell(team: nil, cellType: .add)
                .teamCellViewModifier()
                .onTapGesture {
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

enum TeamCellType {
    case add
    case select
}

struct TeamCell: View {

    let team: Team?
    let cellType: TeamCellType

    var body: some View {
        HStack(alignment: .center) {
            Image(asset: CommonAsset.uniform)
                .resizable()
                .frame(width: 36, height: 36)
                .padding(.leading, 34)
            Spacer()
            Text(cellType == .select ? team!.teamName : "+ 새로운 팀 추가")
                .foregroundStyle(cellType == .select ? Color.colorBlack : Color.colorLightGray)
                .font(.Pretendard.black14.font)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(height: 60)
        .background(.white)
    }
}
