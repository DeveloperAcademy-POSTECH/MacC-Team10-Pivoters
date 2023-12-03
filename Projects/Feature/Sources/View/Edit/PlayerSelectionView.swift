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
                    PlayerCell(observable: $observable, human: $observable.humans[index])
                }
            }
            .padding()
            .onChange(of: observable.team.teamMembers) {
                observable.sortHumans()
            }
            .onChange(of: observable.isChangeEditPlayerPresented) {
                observable.lineup.trigger = Int.random(in: 0...100)
            }
            .sheet(isPresented: $observable.isChangeEditPlayerPresented) {
                if let editHuman = observable.editHuman {
                    AddPlayerView(observable: AddPlayerObservable(playerName: editHuman.name,
                                                                  team: observable.team,
                                                                  human: editHuman,
                                                                  addPlayerInfo: .edit),
                                  addPlayerInfo: .edit)
                    .presentationDetents([.fraction(0.5)])
                    .presentationBackground(.regularMaterial)
                }
            }
        }
    }

    func addPlayerCell() -> some View {
        NavigationLink {
            AddPlayerView(observable: AddPlayerObservable(team: observable.team,
                                                          addPlayerInfo: .add),
                          addPlayerInfo: .add)
        } label: {
            VStack {
                ZStack {
                    Image(asset: CommonAsset.playerAddButton)
                }
                Text(String(localized: "Add Player"))
                    .font(.Pretendard.regular12.font)
            }
        }

        //        .onTapGesture {
        //            observable.isChangeAddPlayerPresented.toggle()
        //            print("Hi")
        //        }
        //        .sheet(isPresented: $observable.isChangeAddPlayerPresented) {
        //            AddPlayerView(observable: AddPlayerObservable(team: observable.team,
        //                                                          addPlayerInfo: .add),
        //                          addPlayerInfo: .add)
        //                .presentationDetents([.fraction(0.5)])
        //                .presentationBackground(.regularMaterial)
        //        }
    }
}

struct PlayerCell: View {
    @Binding var observable: PlayerSelectionObservable
    @Binding var human: Human

    var body: some View {
        if observable.lineup.selectionPlayerIndex == nil {
            NavigationLink {
                AddPlayerView(observable: AddPlayerObservable(playerName: human.name,
                                                              team: observable.team,
                                                              human: human,
                                                              addPlayerInfo: .edit),
                              addPlayerInfo: .edit)
            } label: {
                playerName()
            }
        } else {
            playerName()
                .onTapGesture {
                    observable.selectPlayer(human)
                }
        }
    }

    func playerName() -> some View {
        VStack {
            ZStack {
                if let index = observable.players.firstIndex(where: { $0.human?.id == human.id}) {
                    if index < observable.lineup.formation.rawValue {
                        Image(asset: CommonAsset.clickedPlayerButton)
                        Text("\(human.name.first?.description ?? "")")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundStyle(Color.white)
                    } else {
                        Image(asset: CommonAsset.playerButton)
                        Text("\(human.name.first?.description ?? "")")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundStyle(Color.black)
                    }
                } else {
                    Image(asset: CommonAsset.playerButton)
                    Text("\(human.name.first?.description ?? "")")
                        .font(.Pretendard.headerNormal.font)
                        .foregroundStyle(Color.black)
                }
            }
            Text("\(human.name)")
                .font(.Pretendard.regular12.font)
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
