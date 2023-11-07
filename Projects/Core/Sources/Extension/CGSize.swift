//
//  CGSize.swift
//  Core
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

extension CGSize {
    public static func + (lhs: Self, rhs: Self) -> Self {
        if lhs.width + rhs.width > 0, lhs.height + rhs.height > 0 {
            CGSize(width: min(lhs.width + rhs.width, 180), height: min(lhs.height + rhs.height, 120))
        } else if lhs.width + rhs.width < 0, lhs.height + rhs.height < 0 {
            CGSize(width: max(lhs.width + rhs.width, -180), height: max(lhs.height + rhs.height, -110))
        } else if lhs.width + rhs.width > 0, lhs.height + rhs.height < 0 {
            CGSize(width: min(lhs.width + rhs.width, 180), height: max(lhs.height + rhs.height, -110))
        } else if lhs.width + rhs.width < 0, lhs.height + rhs.height > 0 {
            CGSize(width: max(lhs.width + rhs.width, -180), height: min(lhs.height + rhs.height, 120))
        } else {
            CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
        }
    }
}
