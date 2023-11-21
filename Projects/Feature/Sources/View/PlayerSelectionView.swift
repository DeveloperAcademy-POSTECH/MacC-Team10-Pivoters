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
            ForEach(observable.team.teamMembers.indices, id: \.hashValue) { index in
                PlayerCell(human: $observable.team.teamMembers[index], observable: observable)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(-8)
    }

    func addPlayerCell() -> some View {
        HStack {
            Image(asset: CommonAsset.addButton)
            Text(String(localized: "Add Player"))
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
    @Binding var human: Human
    @State var editPlayer = false
    var observable: PlayerSelectionObservable
    let limitLength: Int = 10

    var body: some View {
        HStack {
            Image(asset: CommonAsset.circleUniform)
                .onTapGesture {
                    print("선수 선택")
                    observable.selectPlayer(human)
                }
            if editPlayer {
                VStack {
                    TextField("\(human.name)", text: $human.name)
                        .font(.Pretendard.regular12.font)
                        .textFieldStyle(.automatic)
                        .onReceive(human.name.publisher.collect()) { newText in
                                        if newText.count > limitLength {
                                            human.name = String(newText.prefix(limitLength))
                                        }
                                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }.padding(.horizontal, 10)
            } else {
                HStack {
                    Text(human.name)
                        .font(.Pretendard.regular12.font)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Spacer()
                    if observable.currentIndex == 0 {
                        Text(String(localized: "Registered"))
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
                    observable.selectPlayer(human)
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
