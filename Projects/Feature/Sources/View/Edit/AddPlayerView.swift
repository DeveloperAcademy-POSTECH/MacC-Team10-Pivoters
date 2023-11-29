//
//  AddPlayerView.swift
//  Feature
//
//  Created by 박승찬 on 11/29/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct AddPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var observable: AddPlayerObservable

    var body: some View {
        VStack {
            HStack {
                Text(String(localized: "Add Player"))
                    .font(.Pretendard.title.font)
                    .foregroundColor(.colorBlack)
                    .padding(.top, 8)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.colorLightGray)
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 16)
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
                        Text(String(localized: "Add Player"))
                            .font(.Pretendard.headerNormal.font)
                            .foregroundColor(.colorWhite)
                    }
            }
            .padding(.bottom, 20)
            .disabled(!observable.isButtonEnabled)
        }
        .submitLabel(.done)
    }
}
