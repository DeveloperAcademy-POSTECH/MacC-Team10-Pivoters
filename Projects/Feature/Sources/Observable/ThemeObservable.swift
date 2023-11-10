//
//  ThemeObservable.swift
//  Feature
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Common

@Observable
final class ThemeObservable {
    let theme: [Theme] = [.blueGray, .blackGreen, .orangeGray, .skyGray]
    var selectedTheme: Theme = .blueGray 
}
