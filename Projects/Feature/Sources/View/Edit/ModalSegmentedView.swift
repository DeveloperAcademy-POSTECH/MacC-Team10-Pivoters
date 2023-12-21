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
    
    @Binding var editType: EditType

    var team: Team
    var lineup: Lineup
    let currentIndex: Int

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 28)
                HStack(spacing: 24) {
                    segmentedControl(buttonType: .management)
                    segmentedControl(buttonType: .player)
                    segmentedControl(buttonType: .uniform)
                    segmentedControl(buttonType: .theme)
                    Spacer()
                }
                .padding(.horizontal, 20)

                switch editType {
                case .management:
                    TeamManagementView(observable: TeamManagementObservable(team: team,
                                                                            lineup: lineup))
                    .padding(.top, 24)
                case .player:
                    PlayerSelectionView(observable:
                                            PlayerSelectionObservable(
                                                team: team,
                                                lineup: lineup,
                                                currentIndex: currentIndex))
                    .padding(.top, 20)
                case .uniform:
                    UniformView(observable: UniformObservable(lineup: lineup))
                        .padding(.top, 20)
                case .theme:
                    ThemeView(observable: ThemeObservable(lineup: lineup))
                        .padding(.top, 24)
                }
                Spacer()
            }
            .background(.regularMaterial)
            .tint(Color.black)
        }
    }

    func segmentedControl(buttonType: EditType) -> some View {
        Button {
            lineup.selectionPlayerIndex = nil
            editType = buttonType
        } label: {
            Text(buttonType.title)
                .foregroundColor(editType == buttonType ? .colorBlack : .colorLightGray)
                .font(.Pretendard.semiBold14.font)
        }
    }

}

enum EditType: String {
    case management
    case player
    case uniform
    case theme

    var title: String {
        switch self {
        case .management:
            String(localized: "Team Info")
        case .player:
            String(localized: "Player")
        case .uniform:
            String(localized: "Uniform")
        case .theme:
            String(localized: "Theme")
        }
    }
}
