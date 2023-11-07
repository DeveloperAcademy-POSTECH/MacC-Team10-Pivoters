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
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
