//
//  TeamManagementView.swift
//  Feature
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct TeamManagementView: View {

//    let colors = ["4-3-3", "3-5-2", "4-4-2"]
//    @State var selectedColors = "4-3-3"
    @State var observable: TeamManagementObservable

    init(observable: TeamManagementObservable) {
        self.observable = observable
    }

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(uiColor: .systemGray6))
                .frame(height: 54)
                .overlay {
                    formationPicker
                }
                .padding(.horizontal, 20)

            Button {

            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text("팀 이름")
                                .font(.Pretendard.semiBold14.font)
                            Spacer()
                            Text("토트넘 핫수퍼")
                                .font(.Pretendard.regular14.font)
                                .tint(Color(uiColor: .lightGray))
                        }
                        .padding(.horizontal, 12)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            Button {

            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .frame(height: 54)
                    .overlay {
                        HStack(spacing: 0) {
                            Text("스쿼드 이름")
                                .font(.Pretendard.semiBold14.font)
                            Spacer()
                            Text("1번 라인업")
                                .font(.Pretendard.regular14.font)
                                .tint(Color(uiColor: .lightGray))
                        }
                        .padding(.horizontal, 12)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            Spacer()
        }
    }

    var formationPicker: some View {
        HStack {
            Text("포메이션")
                .font(.Pretendard.semiBold14.font)
                .tint(.colorBlack)
            Spacer()
            Picker("포메이션", selection: $observable.lineup.selectedTypeOfFormation) {
                ForEach(observable.lineup.formation.typeOfFormation, id: \.self) {
                    Text($0.rawValue)
                        .font(.Pretendard.black14.font)
                }
            }
            .foregroundColor(.colorBlack)
            .onChange(of: observable.lineup.selectedTypeOfFormation) { _, selectedFormation in
                observable.changeFormation(selectedFormation)
            }
            .tint(.gray)
            .pickerStyle(.menu)
        }
        .padding(.leading, 12)
    }
}
