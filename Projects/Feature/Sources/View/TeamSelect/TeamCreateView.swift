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
    @State var observable: TeamCreateObservable

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

            TextField("팀명", text: $observable.teamName)
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
                observable.createTeam()
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.indigo)
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                    .overlay {
                        Text("추가")
                    }
            }
            .padding(.bottom, 20)
        }

    }
}
