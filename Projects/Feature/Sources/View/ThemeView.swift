//
//  ThemeView.swift
//  Feature
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Core
import Common

struct ThemeView: View {
    @State var observable: ThemeObservable

    let themeSize = (UIScreen.main.bounds.width - 52) / 2 // padding 40 + spacing 12

    let gridItem: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 52) / 2), spacing: 12),
        GridItem(.fixed((UIScreen.main.bounds.width - 52) / 2), spacing: 12)
    ]

    init(observable: ThemeObservable) {
        self.observable = observable
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItem) {
                ForEach(observable.theme, id: \.self) { theme in
                    themeCell(theme: theme,
                              isSelected: observable.lineup.theme == theme)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
    }

    func themeCell(theme: Theme, isSelected: Bool) -> some View {
        return theme.preview
            .resizable()
            .opacity(isSelected ? 0.7 : 1)
            .cornerRadius(8)
            .frame(width: themeSize, height: themeSize)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.colorBlue, lineWidth: 1.5)
                        .padding(1)
                }
            }
            .onTapGesture {
                /// Todo
                /// - 이후에 lineup 모델의 프로퍼티에 theme이 추가되어야 함.
                /// - selectedTheme이 메인뷰에 있는 lineup 인스턴스의 theme이 되어야 함.
                observable.lineup.theme = theme
            }
    }
}
