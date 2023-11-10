//
//  Field.swift
//  Common
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

public enum Theme {
    case blueGray
    case blackGreen
    case orangeGray
    case skyGray

    public var image: Image {
        switch self {
        case .blueGray:
            Image(asset: CommonAsset.themeBlueGray)
        case .blackGreen:
            Image(asset: CommonAsset.themeBlackGreen)
        case .orangeGray:
            Image(asset: CommonAsset.themeOrangeGray)
        case .skyGray:
            Image(asset: CommonAsset.themeSkyGray)
        }
    }
}
