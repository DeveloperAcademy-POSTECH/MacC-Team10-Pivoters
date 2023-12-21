//
//  TeamCell.swift
//  Feature
//
//  Created by 한지석 on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Core
import Common

enum TeamCellType {
    case create
    case select
}

struct TeamCell: View {

    let team: Team?
    let cellType: TeamCellType
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center) {
            if let team = team {
                let lineup = team.lineup.filter { $0.index == 0 }.first
                if let lineup = lineup {
                    OverlapUniform(uniform: Uniform(rawValue: team.lineup[0].selectedUniform) ?? .plain1,
                                   uniformSize: 36,
                                   primaryColor: lineup.primaryColor,
                                   secondaryColor: lineup.secondaryColor,
                                   isGoalkeeper: false)
                    .padding(.leading, 34)
                }
            } else {
                Image(asset: CommonAsset.uniform)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.leading, 34)
            }
            Spacer()
            Text(cellType == .select ? team!.teamName : String(localized: "+ add new team"))
                .foregroundStyle(cellType == .select ? Color.colorBlack : Color.colorLightGray)
                .font(.Pretendard.black14.font)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(height: 60)
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.colorBlue, lineWidth: 1.5)
                    .padding(1)
            }
        }
        .background(.white)
    }
}
