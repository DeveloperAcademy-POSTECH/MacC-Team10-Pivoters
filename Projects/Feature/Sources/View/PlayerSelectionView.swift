//
//  PlayerSelectionView.swift
//  Feature
//
//  Created by 박승찬 on 11/11/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

struct PlayerSelectionView: View {
    @State var observable = PlayerSelectionObservable()
    var body: some View {
        List {
            playerCell(.addPlayer)
            ForEach($observable.playerList) { player in
                playerCell(.player, player: player.wrappedValue)
            }
            .onDelete(perform: { indexSet in
                observable.playerList.remove(atOffsets: indexSet)
            })
        }
        .listStyle(.plain)

    }

    func playerCell(_ playerCellType: PlayerCellType, player: Player? = nil) -> some View {
        HStack {
            switch playerCellType {
            case .addPlayer:
                HStack {
                    Image(asset: CommonAsset.addButton)
                    Text("선수 추가")
                }
                .onTapGesture {
                    observable.addPlayer()
                }
            case .player:
                HStack {
                    Image(asset: CommonAsset.cirecleUniform)
                    Text(player?.name ?? "익명")
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
