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
    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        ScrollView {
            addPlayerCell()
            ForEach(observable.playerList.indices, id: \.hashValue) { index in
                PlayerCell(player: $observable.playerList[index])
                    .environment(fieldObservable)
            }
        }

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

struct PlayerCell: View {
    @Binding var player: Player
    @State var editPlayer = false
    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        HStack {
            Image(asset: CommonAsset.cirecleUniform)
                .onTapGesture {
                    print("선수 선택")
                    fieldObservable.selectPlayer(player)
                }
            if editPlayer {
                TextField("\(player.name)", text: $player.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            } else {
                HStack {
                    Text(player.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Spacer()
                    if player.id != nil {
                        Text("등록 완료")
                            .font(.system(size: 10))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(lineWidth: 1.0)
                            )
                    }
                }
                .onTapGesture {
                    print("선수 선택")
                    fieldObservable.selectPlayer(player)
                }
            }
            Image(systemName: "square.and.pencil")
                .onTapGesture {
                    editPlayer.toggle()
                }
        }
        .padding(.horizontal)
    }
}
