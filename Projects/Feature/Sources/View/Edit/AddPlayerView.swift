//
//  AddPlayerView.swift
//  Feature
//
//  Created by 박승찬 on 11/29/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

enum AddPlayerInfo {
    case add
    case edit
}

struct AddPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var observable: AddPlayerObservable
    let addPlayerInfo: AddPlayerInfo

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray5)
                .ignoresSafeArea()
        VStack {
            HStack {
                Text(addPlayerInfo == .add ? String(localized: "Add Player"): String(localized: "Edit Player"))
                    .font(.Pretendard.title.font)
                    .foregroundColor(.colorBlack)
                Spacer()
            }
            .padding(.top, 0)
            .padding(.horizontal, 16)

            TextField(String(localized: "Player name"), text: $observable.playerName)
                .frame(height: 55)
                .foregroundStyle(Color.colorBlack)
                .font(.Pretendard.headerNormal.font)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .onReceive(observable.playerName.publisher.collect()) {
                    if $0.count > 15 {
                        observable.playerName = String($0.prefix(15))
                    }
                }
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            Divider()
                .padding(.horizontal, 16)
            Spacer()
            Button {
                observable.addPlayer()
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(observable.isButtonEnabled ? Color.colorBlue : Color.colorLightGray)
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text(addPlayerInfo == .add ? String(localized: "Add Player"): String(localized: "Change"))
                            .font(.Pretendard.headerNormal.font)
                            .foregroundColor(.colorWhite)
                    }
            }
            .padding(.bottom, 20)
            .disabled(!observable.isButtonEnabled)
        }
        }
        .submitLabel(.done)
        .onSubmit {
            guard observable.isButtonEnabled else { return }
            observable.addPlayer()
            dismiss()
        }
    }
}
