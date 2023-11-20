//
//  ModalSegmentedView.swift
//  Feature
//
//  Created by 한지석 on 11/9/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Core
import Common

struct ModalSegmentedView: View {
    @State var editType: EditType = .theme
    var team: Team
    var lineup: Lineup

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 25)
            HStack(spacing: 24) {
                segmentedControl(buttonType: .theme)
                segmentedControl(buttonType: .uniform)
                segmentedControl(buttonType: .player)
                segmentedControl(buttonType: .management)
                Spacer()
            }
            .padding(.horizontal, 20)

            switch editType {
            case .theme:
                ThemeView(observable: ThemeObservable(lineup: lineup))
                    .padding(.top, 24)
            case .uniform:
                UniformView(observable: UniformObservable(lineup: lineup))
                    .padding(.top, 24)
            case .player:
                PlayerSelectionView(observable: PlayerSelectionObservable(lineup: lineup))
                    .padding(.top, 24)
            case .management:
                TeamManagementView(observable: TeamManagementObservable(team: team,
                                                                        lineup: lineup))
                .padding(.top, 24)
            }
            Spacer()
        }
        .background(Color.white)
        .tint(Color.black)
    }

    func segmentedControl(buttonType: EditType) -> some View {
        Button {
            self.editType = buttonType
        } label: {
            Text(buttonType.title)
                .foregroundColor(editType == buttonType ? .colorBlack : .colorLightGray)
                .font(.Pretendard.semiBold14.font)
        }
    }

}

enum EditType {
    case theme
    case uniform
    case player
    case management

    var title: String {
        switch self {
        case .theme:
            "테마"
        case .uniform:
            "유니폼"
        case .player:
            "선수"
        case .management:
            "팀 관리"
        }
    }
}
