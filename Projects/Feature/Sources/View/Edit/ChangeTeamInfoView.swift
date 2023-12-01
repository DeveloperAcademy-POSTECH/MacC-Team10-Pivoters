//
//  ChangeTeamInfoView.swift
//  Feature
//
//  Created by 한지석 on 11/21/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI
import Common

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
        ZStack {
            Color(uiColor: .systemGray5)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Text(changeTeamInfo == .team ?
                         String(localized: "Change Team Name")
                         : String(localized: "Change Lineup Name"))
                    .font(.Pretendard.title.font)
                    .foregroundColor(.colorBlack)
                    Spacer()
                }
                .padding(.top, 0)
                .padding(.horizontal, 16)

                TextField(changeTeamInfo == .team ? String(localized: "Team Name") : String(localized: "Lineup Name"), text: $observable.name)
                    .frame(height: 55)
                    .foregroundStyle(Color.colorBlack)
                    .font(.Pretendard.headerNormal.font)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onReceive(observable.name.publisher.collect()) {
                        if $0.count > 20 {
                            observable.name = String($0.prefix(20))
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
                            Text(String(localized: "Change"))
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
            observable.changeName()
            dismiss()
        }
    }
}
