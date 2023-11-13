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
    @State var observable: PlayerSelectionObservable
    var body: some View {
        ScrollView {
            addPlayerCell()
            ForEach($observable.playerList) { player in
                PlayerCell(player: player)
            }
            .onDelete(perform: { indexSet in
                observable.playerList.remove(atOffsets: indexSet)
            })
        }
        .listStyle(.plain)

    }

    func addPlayerCell() -> some View {
        HStack {
            Image(asset: CommonAsset.addButton)
            Text("선수 추가")
                .padding(.horizontal)
            Spacer()
        }
        .padding(.horizontal)
        .onTapGesture {
            observable.addPlayer()
        }
    }
}

enum PlayerCellType {
    case addPlayer
    case player
}

struct PlayerCell: View {
    @Binding var player: Player
    @State var editPlayer = false
    var body: some View {
        HStack {
            HStack {
                Image(asset: CommonAsset.cirecleUniform)
                if editPlayer {
                    TextField("\(player.name)", text: $player.name)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                } else {
                    Text(player.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
            .onTapGesture {
                print("선수 선택")
            }
            Image(systemName: "square.and.pencil")
                .onTapGesture {
                    editPlayer.toggle()
                }
        }
        .padding(.horizontal)
    }
}
