//
//  Theme.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum Theme: Int, Codable {
    case blueGray
    case blueGreen
    case blueBlack
    case blackGray
    case blackBlue
    case grayBlack
    case lightGrayBlue
    case whiteGreen
    case purpleClear
    case blueClear

    public static let themeArray: [Theme] = [
        .blueGray,
        .blueGreen,
        .blueBlack,
        .blackGray,
        .blackBlue,
        .grayBlack,
        .lightGrayBlue,
        .whiteGreen,
        .purpleClear,
        .blueClear
    ]
}
