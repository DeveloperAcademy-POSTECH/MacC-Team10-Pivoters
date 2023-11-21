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
            // isGoalkeeper
            if player.isGoalkeeper {
                OverlapUniform(uniform: lineup.uniform,
                               uniformSize: 50,
                               primaryColor: lineup.goalkeeperPrimaryColor,
                               secondaryColor: lineup.secondaryColor,
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

            Text(player.human?.name ?? " ")
                .coordinateSpace(name: lineup.trigger)
                .task(id: lineup.trigger) {
                    print(lineup.trigger)
                }
                .font(.Pretendard.semiBold10.font)
                .foregroundStyle(lineup.selectionPlayerIndex == index ? .white: theme.textColor)
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(lineup.selectionPlayerIndex == index ? Color(asset: CommonAsset.tintColor): theme.nameField)
                        .frame(minWidth: 40)
                        .frame(height: 17)
                )
                .offset(y: -20)
        }
    }
}
