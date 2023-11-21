//
//  TeamCreateView.swift
//  Feature
//
//  Created by 한지석 on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct TeamCreateView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var observable: TeamCreateObservable

    let limitTeamName: Int = 15

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("팀 추가")
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

            TextField("팀명", text: $observable.teamName)
                .frame(height: 55)
                .foregroundStyle(Color.colorBlack)
                .font(.Pretendard.headerNormal.font)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .onReceive(observable.teamName.publisher.collect()) {
                    if $0.count > limitTeamName {
                        observable.teamName = String($0.prefix(limitTeamName))
                    }
                }
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            Divider()
                .padding(.horizontal, 16)
            Spacer()
            Button {
                // MARK: createTeam
                observable.createTeam()
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(observable.isButtonEnabled ? Color.colorBlue : Color.colorLightGray)
                    .frame(height: 60)
                    .padding(.horizontal, 16)
                    .overlay {
                        Text("추가")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundColor(Color.white)
                    }
            }
            .padding(.bottom, 20)
            .disabled(!observable.isButtonEnabled)
        }
        .submitLabel(.done)
        .onSubmit {
            guard observable.isButtonEnabled else { return }
            observable.createTeam()
            dismiss()
        }

    }
}
