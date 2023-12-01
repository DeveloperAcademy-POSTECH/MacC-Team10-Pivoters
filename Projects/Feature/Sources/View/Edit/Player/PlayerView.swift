//
//  PlayerView.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

struct PlayerView: View {
    var theme: Theme
    var player: Player
    var lineup: Lineup
    var index: Int

    var body: some View {
        VStack {
            if player.human != nil {
                if player.isGoalkeeper {
                    OverlapUniform(uniform: lineup.uniform,
                                   uniformSize: 50,
                                   primaryColor: theme.goalkeeperPrimaryColor,
                                   secondaryColor: theme.goalkeeperSecondaryColor,
                                   isSelected: false,
                                   isGoalkeeper: true)
                } else {
                    OverlapUniform(uniform: lineup.uniform,
                                   uniformSize: 50,
                                   primaryColor: lineup.primaryColor,
                                   secondaryColor: lineup.secondaryColor,
                                   isSelected: false,
                                   isGoalkeeper: false)
                }
            } else {
                Image(asset: lineup.selectionPlayerIndex == index ?
                      CommonAsset.selectedEmptyUniform : CommonAsset.emptyUniform)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
            }
            Text(player.human?.name ?? String(localized: "Empty"))
                .coordinateSpace(name: lineup.trigger)
                .font(.Pretendard.semiBold10.font)
                .foregroundStyle(lineup.selectionPlayerIndex == index ? .white: theme.textColor)
                .padding(.vertical, 3)
                .padding(.horizontal, 9)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(lineup.selectionPlayerIndex == index ? Color(asset: CommonAsset.tintColor): theme.nameField)
                        .frame(minWidth: 40)
                )
                .offset(y: -20)
        }

    }
}
