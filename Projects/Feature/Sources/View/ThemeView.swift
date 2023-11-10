//
//  ThemeView.swift
//  Feature
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

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
                              isSelected: observable.selectedTheme == theme)
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func themeCell(theme: Theme, isSelected: Bool) -> some View {
        return theme.image
            .resizable()
            .opacity(isSelected ? 0.7 : 1)
            .cornerRadius(8)
            .frame(width: themeSize, height: themeSize)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.tint, lineWidth: 1.5)
                        .padding(1)
                }
            }
            .onTapGesture {
                observable.selectedTheme = theme
                ///Todo
                /// - Theme Asset 고르는 enum에 맞추어 ThemeType도 같이 변해야 함.
            }
    }
}
