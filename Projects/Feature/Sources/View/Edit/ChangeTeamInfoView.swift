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
    @State var observable: ChangeTeamInfoObservable
    let changeTeamInfo: ChangeTeamInfo

    init(observable: ChangeTeamInfoObservable,
         changeTeamInfo: ChangeTeamInfo) {
        self.changeTeamInfo = changeTeamInfo
        let observable = observable
        _observable = State(initialValue: observable)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
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
            .padding(.trailing, 16)

            TextField(changeTeamInfo == .team ? String(localized: "Team Name") : String(localized: "Squad Name"), text: $observable.name)
                .frame(height: 55)
                .foregroundStyle(Color.colorBlack)
                .font(.Pretendard.headerNormal.font)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 24)
            Divider()
                .padding(.horizontal, 24)
            Spacer()
            Button {
                // MARK: createTeam
                observable.changeName()
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255))
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text(String(localized: "Change"))
                            .font(.Pretendard.headerNormal.font)
                            .foregroundColor(.colorWhite)
                    }
            }
            .padding(.bottom, 20)
        }
    }
}
