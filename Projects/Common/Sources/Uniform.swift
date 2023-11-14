//
//  Uniform.swift
//  Common
//
//  Created by 한지석 on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

import Core

extension Uniform {

    public var primary: Image {
        switch self {
        case .plain:
            Image(asset: CommonAsset.plainPrimary)
        case .stripe:
            Image(asset: CommonAsset.stripePrimary)
        }
    }

    public var secondary: Image? {
        switch self {
        case .plain:
            nil
        case .stripe:
            Image(asset: CommonAsset.stripeSecondary)
        }
    }

    public var border: Image {
        switch self {
        case .plain:
            Image(asset: CommonAsset.plainBorder)
        case .stripe:
            Image(asset: CommonAsset.stripeBorder)
        }
    }

}
