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
        case .plain1:
            Image(asset: CommonAsset.plain1Primary)
        case .plain2:
            Image(asset: CommonAsset.plain2Primary)
        case .stripe1:
            Image(asset: CommonAsset.stripe1Primary)
        case .stripe2:
            Image(asset: CommonAsset.stripe2Primary)
        case .stripe3:
            Image(asset: CommonAsset.stripe3Primary)
        case .seperate1:
            Image(asset: CommonAsset.seperate1Primary)
        case .seperate2:
            Image(asset: CommonAsset.seperate2Primary)
        }
    }

    public var secondary: Image? {
        switch self {
        case .plain1:
            nil
        case .plain2:
            nil
        case .stripe1:
            Image(asset: CommonAsset.stripe1Secondary)
        case .stripe2:
            Image(asset: CommonAsset.stripe2Secondary)
        case .stripe3:
            Image(asset: CommonAsset.stripe3Secondary)
        case .seperate1:
            Image(asset: CommonAsset.seperate1Secondary)
        case .seperate2:
            Image(asset: CommonAsset.seperate2Secondary)
        }
    }

    public var border: Image {
        switch self {
        case .plain1:
            Image(asset: CommonAsset.plain1Border)
        case .plain2:
            Image(asset: CommonAsset.plain2Border)
        case .stripe1:
            Image(asset: CommonAsset.stripe1Border)
        case .stripe2:
            Image(asset: CommonAsset.stripe2Border)
        case .stripe3:
            Image(asset: CommonAsset.stripe3Border)
        case .seperate1:
            Image(asset: CommonAsset.seperate1Border)
        case .seperate2:
            Image(asset: CommonAsset.seperate2Border)
        }

    }

    public var goalkeeperPrimary: Image {
        Image(asset: CommonAsset.gkPlainPrimary)
    }

    public var goalkeeperSecondary: Image? {
        nil
    }

    public var goalkeeperBorder: Image {
        Image(asset: CommonAsset.gkPlainBorder)
    }

}
