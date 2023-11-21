//
//  ChangeTeamInfoView.swift
//  Feature
//
//  Created by 한지석 on 11/21/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

enum ChangeTeamInfo {
    case team
    case squad
}

struct ChangeTeamInfoView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var observable: ChangeTeamInfoObservable
    let changeTeamInfo: ChangeTeamInfo

    init(observable: ChangeTeamInfoObservable,
         changeTeamInfo: ChangeTeamInfo) {
        self.changeTeamInfo = changeTeamInfo
        let observable = observable
        _observable = StateObject(wrappedValue: observable)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(changeTeamInfo == .team ? "팀명 변경" : "스쿼드명 변경")
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

            TextField(changeTeamInfo == .team ? "팀 이름" : "스쿼드 이름", text: $observable.name)
                .frame(height: 55)
                .foregroundStyle(Color.colorBlack)
                .font(.Pretendard.headerNormal.font)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .onReceive(observable.name.publisher.collect()) {
                    if $0.count > 15 {
                        observable.name = String($0.prefix(15))
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
                observable.changeName()
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(observable.isButtonEnabled ? Color.colorBlue : Color.colorLightGray)
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text("변경")
                            .font(.Pretendard.headerNormal.font)
                            .foregroundColor(.colorWhite)
                    }
            }
            .padding(.bottom, 20)
            .disabled(!observable.isButtonEnabled)
        }
        .submitLabel(.done)
        .onSubmit {
            guard observable.isButtonEnabled else { return }
            observable.changeName()
            dismiss()
        }
    }
}
