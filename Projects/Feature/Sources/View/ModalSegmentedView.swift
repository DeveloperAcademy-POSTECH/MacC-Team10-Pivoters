//
//  ModalSegmentedView.swift
//  Feature
//
//  Created by 한지석 on 11/9/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct ModalSegmentedView: View {

    @State var editType: EditType = .theme

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 25)
            HStack(spacing: 24) {
                segmentedControl(buttonType: .theme)
                segmentedControl(buttonType: .uniform)
                segmentedControl(buttonType: .player)
                segmentedControl(buttonType: .squad)
                Spacer()
            }
            .padding(.horizontal, 20)

            switch editType {
            case .theme:
                ThemeView(observable: ThemeObservable())
                    .padding(.top, 24)
            case .uniform:
                UniformView(observable: UniformObservable())
                    .padding(.top, 24)
            case .player:
                Text("Player")
            case .squad:
                Text("Squad")
            }
        }
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
    case squad

    var title: String {
        switch self {
        case .theme:
            "테마"
        case .uniform:
            "유니폼"
        case .player:
            "선수"
        case .squad:
            "스쿼드"
        }
    }
}

#Preview {
    ModalSegmentedView()
}

