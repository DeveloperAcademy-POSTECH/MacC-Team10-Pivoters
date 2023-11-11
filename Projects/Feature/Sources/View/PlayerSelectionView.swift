//
//  PlayerSelectionView.swift
//  Feature
//
//  Created by 박승찬 on 11/11/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct PlayerSelectionView: View {
    var body: some View {
        List {
            playerCell(.addPlayer)
            playerCell(.player)
        }
        .listStyle(.plain)

    }

    func playerCell(_ playerCellType: PlayerCellType) -> some View {
        HStack {
            switch playerCellType {
            case .addPlayer:
                Image(asset: CommonAsset.addButton)
                Text("선수 추가")
            case .player:
                HStack {
                    Image(asset: CommonAsset.cirecleUniform)
                    Text("새로 추가된 선수")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .onTapGesture {
                    print("선수 선택")
                }
                Image(systemName: "square.and.pencil")
                    .onTapGesture {
                        print("편집 버튼 클릭")
                    }
            }
        }
        .listRowSeparator(.hidden)
    }
}

enum PlayerCellType {
    case addPlayer
    case player
}

#Preview {
    PlayerSelectionView()
}
