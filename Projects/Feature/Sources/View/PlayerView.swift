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

    var body: some View {
        VStack {
            Image(asset: CommonAsset.uniform)
                .resizable()
                .scaledToFit()
                .frame(width: 43, height: 43)
            Text(player.name)
                .font(.Pretendard.semiBold10.font)
                .foregroundStyle(theme.textColor)
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(theme.nameField)
                        .frame(minWidth: 40)
                )
                .offset(y: -12)
        }
    }
}
