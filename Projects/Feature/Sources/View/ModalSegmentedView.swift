//
//  ModalSegmentedView.swift
//  Feature
//
//  Created by 한지석 on 11/9/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct ModalSegmentedView: View {

    @State var editType: EditType = .theme
    @Environment(FieldObservable.self) var fieldObservable
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 30)
            HStack(spacing: 24) {
                segmentedControl(buttonType: .theme)
                segmentedControl(buttonType: .uniform)
                segmentedControl(buttonType: .player)
                segmentedControl(buttonType: .squad)
                Spacer()
            }
            .padding(.horizontal, 20)
            Spacer()
            switch editType {
            case .theme:
                Text("Theme")
            case .uniform:
                UniformView(observable: UniformObservable())
            case .player:
                PlayerSelectionView(observable: PlayerSelectionObservable())
                    .environment(fieldObservable)
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
                .opacity(editType == buttonType ? 1 : 0.4)
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
