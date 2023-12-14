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
                ForEach(observable.teamPlayers.indices, id: \.hashValue) { index in
                    PlayerCell(observable: $observable, teamPlayer: $observable.teamPlayers[index])
                }
            }
            .padding()
            .onChange(of: observable.team.teamPlayers) {
                observable.sortHumans()
            }
            .onChange(of: observable.isChangeEditPlayerPresented) {
                observable.lineup.trigger = Int.random(in: 0...100)
            }
            .sheet(isPresented: $observable.isChangeEditPlayerPresented) {
                if let editTeamPlayer = observable.editTeamPlayer {
                    AddPlayerView(observable: AddPlayerObservable(playerName: editTeamPlayer.name,
                                                                  team: observable.team,
                                                                  teamPlayer: editTeamPlayer,
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
    @Binding var teamPlayer: TeamPlayer

    var body: some View {
        if observable.lineup.selectionPlayerIndex == nil {
            NavigationLink {
                AddPlayerView(observable: AddPlayerObservable(playerName: teamPlayer.name,
                                                              team: observable.team,
                                                              teamPlayer: teamPlayer,
                                                              addPlayerInfo: .edit),
                              addPlayerInfo: .edit)
            } label: {
                playerName()
            }
        } else {
            playerName()
                .onTapGesture {
                    observable.selectPlayer(teamPlayer)
                }
        }
    }

    func playerName() -> some View {
        VStack {
            ZStack {
                if let index = observable.players.firstIndex(where: { $0.teamPlayer?.id == teamPlayer.id}) {
                    if index < observable.lineup.selectedPlayType {
                        Image(asset: CommonAsset.clickedPlayerButton)
                        Text("\(teamPlayer.name.first?.description ?? "")")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundStyle(Color.white)
                    } else {
                        Image(asset: CommonAsset.playerButton)
                        Text("\(teamPlayer.name.first?.description ?? "")")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundStyle(Color.black)
                    }
                } else {
                    Image(asset: CommonAsset.playerButton)
                    Text("\(teamPlayer.name.first?.description ?? "")")
                        .font(.Pretendard.headerNormal.font)
                        .foregroundStyle(Color.black)
                }
            }
            Text("\(teamPlayer.name)")
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
