//
//  Theme.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum Theme: String, Codable {
    case blueGray = "blueGray"
    case blueGreen = "blueGreen"
    case blueBlack = "blueBlack"
    case blackGray = "blackGray"
    case blackBlue = "blackBlue"
    case grayBlack = "grayBlack"
    case lightGrayBlue = "lightGrayBlue"
    case whiteGreen = "whiteGreen"
    case purpleClear = "purpleClear"
    case blueClear = "blueClear"

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
