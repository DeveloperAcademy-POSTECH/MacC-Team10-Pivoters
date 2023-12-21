//
//  ThemeObservable.swift
//  Feature
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
final class ThemeObservable {
    var theme: [Theme] = Theme.themeArray
    var lineup: Lineup

    init(lineup: Lineup) {
        self.lineup = lineup
        sortTheme()
    }

    func sortTheme() {
        theme.sort(by: { pre, _ in
            if pre.rawValue == self.lineup.selectedTheme {
                return true
            }
            return false
        })
    }

}
