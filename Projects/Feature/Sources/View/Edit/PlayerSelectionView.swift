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
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                addPlayerCell()
                ForEach(observable.humans.indices, id: \.hashValue) { index in
                    PlayerCell(observable: $observable, human: observable.humans[index])
                }
            }
            .padding()
            .onChange(of: observable.team.teamMembers) {
                observable.sortHumans()
            }
        }
    }

    func addPlayerCell() -> some View {
        VStack {
            ZStack {
                Image(asset: CommonAsset.playerAddButton)
            }
            Text(String(localized: "Add Player"))
                .font(.Pretendard.regular12.font)
        }
        .onTapGesture {
            observable.isChangeAddPlayerPresented.toggle()
        }
        .sheet(isPresented: $observable.isChangeAddPlayerPresented) {
            AddPlayerView(observable: AddPlayerObservable(team: observable.team,
                                                          addPlayerInfo: .add),
                          addPlayerInfo: .add)
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
        }
    }
}

struct PlayerCell: View {
    @Binding var observable: PlayerSelectionObservable
    var human: Human

    var body: some View {
        VStack {
            ZStack {
                if observable.lineup.players.firstIndex(where: { $0.human?.id == human.id}) != nil {
                    Image(asset: CommonAsset.clickedPlayerButton)
                } else {
                    Image(asset: CommonAsset.playerButton)
                }
                if observable.lineup.players.firstIndex(where: { $0.human?.id == human.id}) != nil {
                    Text("\(human.name.first?.description ?? "")")
                        .font(.Pretendard.headerNormal.font)
                        .foregroundStyle(Color.white)
                } else {
                    Text("\(human.name.first?.description ?? "")")
                        .font(.Pretendard.headerNormal.font)
                        .foregroundStyle(Color.black)
                }
            }
            Text("\(human.name)")
                .font(.Pretendard.regular12.font)
        }
        .onTapGesture {
            if observable.lineup.selectionPlayerIndex == nil {
                observable.isChangeEditPlayerPresented.toggle()
            } else {
                observable.selectPlayer(human)
            }
        }
        .sheet(isPresented: $observable.isChangeEditPlayerPresented) {
            AddPlayerView(observable: AddPlayerObservable(playerName: human.name,
                                                          team: observable.team,
                                                          human: human,
                                                          addPlayerInfo: .edit),
                          addPlayerInfo: .edit)
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
        }
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }
}
