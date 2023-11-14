//
//  Font+.swift
//  Common
//
//  Created by 한지석 on 11/14/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

public extension Font {
    enum FontSystem { 
        case headerLarge
        case headerNormal
        case black14
        case semiBold14
        case regular12
        case subhead

        var pretendard: Font {
            switch self {
            case .headerLarge:
                CommonFontFamily.Pretendard.black.swiftUIFont(size: 22)
            case .headerNormal:
                CommonFontFamily.Pretendard.black.swiftUIFont(size: 18)
            case .black14:
                CommonFontFamily.Pretendard.black.swiftUIFont(size: 14)
            case .semiBold14:
                CommonFontFamily.Pretendard.semiBold.swiftUIFont(size: 14)
            case .regular12:
                CommonFontFamily.Pretendard.regular.swiftUIFont(size: 12)
            case .subhead:
                CommonFontFamily.Pretendard.regular.swiftUIFont(size: 10)
            }
        }
    }
}
