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
                PlayerCell(human: $observable.team.teamMembers[index],
                           observable: observable)
                    .listRowSeparator(.hidden)
            }
        }
        .task(id: observable.lineup.selectionPlayerIndex, {
            observable.isEditedHuman = nil
        })
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
    @Binding var human: Human
    var observable: PlayerSelectionObservable
    let limitLength: Int = 10

    var body: some View {
        HStack {
            Image(asset: CommonAsset.circleUniform)
                .onTapGesture {
                    print("선수 선택")
                    observable.selectPlayer(human)
                }
            VStack {
                TextField("\(human.name)", text: $human.name, onCommit: {
                    observable.isEditedHuman = nil
                })
                    .font(.Pretendard.regular12.font)
                    .textFieldStyle(.automatic)
                    .onReceive(human.name.publisher.collect()) { newText in
                                    if newText.count > limitLength {
                                        human.name = String(newText.prefix(limitLength))
                                    }
                                }
                    .disabled(observable.isEditedHuman != human.id)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(observable.isEditedHuman == human.id ? .gray: .white)
            }
            .padding(.horizontal, 10)
            .onTapGesture {
                if observable.isEditedHuman != human.id {
                    print("선수 선택")
                    observable.selectPlayer(human)
                    observable.isEditedHuman = nil
                }
            }
            Image(systemName: "square.and.pencil")
                .onTapGesture {
                    if observable.isEditedHuman == human.id {
                        observable.isEditedHuman = nil
                    } else {
                        observable.isEditedHuman = human.id
                    }
                }
        }
        .padding(.horizontal, 10)
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }
}
