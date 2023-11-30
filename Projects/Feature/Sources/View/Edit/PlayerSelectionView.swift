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
                    PlayerCell(observable: observable, human: observable.humans[index])
                }
            }
            .padding()
            .task(id: observable.lineup.selectionPlayerIndex, {
                observable.isEditedHuman = nil
            })
            .onChange(of: observable.team.teamMembers) {
                observable.sortHumans()
            }
        }
        .sheet(isPresented: $observable.isChangeAddPlayerPresented) {
            AddPlayerView(observable: AddPlayerObservable(team: observable.team))
                .presentationDetents([.fraction(0.5)])
                .presentationBackground(.regularMaterial)
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
    }
}

struct PlayerCell: View {
    var observable: PlayerSelectionObservable
    var human: Human

    var body: some View {
        VStack {
            ZStack {
                if observable.lineup.players.firstIndex(where: { $0.human?.id == human.id}) != nil {
                    Image(asset: CommonAsset.clickedPlayerButton)
                } else {
                    Image(asset: CommonAsset.playerButton)
                }
                Text("\(human.name.first?.description ?? "")")
                    .font(.Pretendard.headerNormal.font)
            }
            Text("\(human.name)")
                .font(.Pretendard.regular12.font)
        }
        .onTapGesture {
            observable.selectPlayer(human)
        }
    }
}

//struct PlayerCell: View {
//    @Binding var human: Human
//    var observable: PlayerSelectionObservable
//    let limitLength: Int = 15
//
//    var body: some View {
//        HStack {
//            VStack {
//                if observable.lineup.players.firstIndex(where: { $0.human?.id == human.id}) != nil {
//                    Image(systemName: "checkmark.circle")
//                        .foregroundStyle(Color(asset: CommonAsset.tintColor))
//                } else {
//                    Image(systemName: "checkmark.circle")
//                        .foregroundStyle(Color.gray)
//                }
//            }
//            .onTapGesture {
//                if observable.isEditedHuman != human.id {
//                    observable.selectPlayer(human)
//                    observable.isEditedHuman = nil
//                }
//            }
//            VStack {
//                TextField(String(localized: "Player name"), text: $human.name, onCommit: {
//                    observable.isEditedHuman = nil
//                })
//                .submitLabel(.done)
//                .font(.Pretendard.regular12.font)
//                .textFieldStyle(.automatic)
//                .onReceive(human.name.publisher.collect()) { newText in
//                    if newText.count > limitLength {
//                        human.name = String(newText.prefix(limitLength))
//                    }
//                }
//                .disabled(observable.isEditedHuman != human.id)
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(observable.isEditedHuman == human.id ? .gray: .white)
//            }
//            .offset(y: 3)
//            .background(Color.white.opacity(0.1))
//            .padding(.horizontal, 10)
//            .onTapGesture {
//                if observable.isEditedHuman != human.id {
//                    observable.selectPlayer(human)
//                    observable.isEditedHuman = nil
//                }
//            }
//            .task(id: human.name) {
//                observable.lineup.trigger = Int.random(in: 0...10)
//            }
//            Image(systemName: "square.and.pencil")
//                .foregroundStyle(Color.gray)
//                .onTapGesture {
//                    if observable.isEditedHuman == human.id {
//                        observable.isEditedHuman = nil
//                        if human.name.isEmpty {
//                            human.name = String(localized: "Player")
//                        }
//                    } else {
//                        observable.isEditedHuman = human.id
//                    }
//                }
//        }
//        .padding(.horizontal, 10)
//    }
//}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }
}
