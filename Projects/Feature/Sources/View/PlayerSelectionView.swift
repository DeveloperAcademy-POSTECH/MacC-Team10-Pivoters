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
        List {
            addPlayerCell()
                .listRowSeparator(.hidden)
            ForEach(observable.playerList.indices, id: \.hashValue) { index in
                PlayerCell(player: $observable.playerList[index], observable: observable)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(-8)
    }

    func addPlayerCell() -> some View {
        HStack {
            Image(asset: CommonAsset.addButton)
            Text("선수 추가")
                .font(.Pretendard.regular12.font)
                .padding(.horizontal, 10)
            Spacer()
        }
        .padding(.horizontal, 10)
        .onTapGesture {
            observable.addPlayer()
        }
    }
}

struct PlayerCell: View {
    @Binding var player: Player
    @State var editPlayer = false
    var observable: PlayerSelectionObservable
    let limitLength: Int = 10

    var body: some View {
        HStack {
            Image(asset: CommonAsset.circleUniform)
                .onTapGesture {
                    print("선수 선택")
                    observable.selectPlayer(player)
                }
            if editPlayer {
                VStack {
                    TextField("\(player.name)", text: $player.name)
                        .font(.Pretendard.regular12.font)
                        .textFieldStyle(.automatic)
                        .onReceive(player.name.publisher.collect()) { newText in
                                        if newText.count > limitLength {
                                            player.name = String(newText.prefix(limitLength))
                                        }
                                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding(.horizontal, 10)
            } else {
                HStack {
                    Text(player.name)
                        .font(.Pretendard.regular12.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Spacer()
                    if player.id != nil {
                        Text("등록 완료")
                            .font(.Pretendard.subhead.font)
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
                    observable.selectPlayer(player)
                }
            }
            Image(systemName: "square.and.pencil")
                .onTapGesture {
                    editPlayer.toggle()
                }
        }
        .padding(.horizontal, 10)
    }
}
