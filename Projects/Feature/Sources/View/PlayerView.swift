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
    var player: Player

    var body: some View {
        VStack {
            Image(asset: CommonAsset.uniform)
            Text(player.name)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(.white)
                .cornerRadius(4)
                .offset(y: -12)
        }
    }
}
