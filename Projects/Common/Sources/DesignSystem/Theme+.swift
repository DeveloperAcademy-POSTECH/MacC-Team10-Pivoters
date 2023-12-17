//
//  Field.swift
//  Common
//
//  Created by 한지석 on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

import Core

extension Theme {
    public var field: Image {
        switch self {
        case .blueGray:
            Image(asset: CommonAsset.fieldGray)
        case .whiteGreen:
            Image(asset: CommonAsset.fieldGreen)
        case .blackBlue:
            Image(asset: CommonAsset.fieldBlue)
        case .grayBlack:
            Image(asset: CommonAsset.fieldBlack)
        case .blueBlack:
            Image(asset: CommonAsset.fieldBlack)
        case .blackGray:
            Image(asset: CommonAsset.fieldGray)
        case .purpleClear:
            Image(asset: CommonAsset.fieldClear)
        case .blueClear:
            Image(asset: CommonAsset.fieldClear)
        case .blueGreen:
            Image(asset: CommonAsset.fieldGreen)
        case .lightGrayBlue:
            Image(asset: CommonAsset.fieldLightGrayBlue)
        }
    }

    public var background: Image {
        switch self {
        case .blueGray:
            Image(asset: CommonAsset.backgroundBlue)
        case .whiteGreen:
            Image(asset: CommonAsset.backgroundWhite)
        case .blackBlue:
            Image(asset: CommonAsset.backgroundBlack)
        case .grayBlack:
            Image(asset: CommonAsset.backgroundGray)
        case .blueBlack:
            Image(asset: CommonAsset.backgroundBlue)
        case .blackGray:
            Image(asset: CommonAsset.backgroundBlack)
        case .purpleClear:
            Image(asset: CommonAsset.backgroundPurple)
        case .blueClear:
            Image(asset: CommonAsset.backgroundBlueClear)
        case .blueGreen:
            Image(asset: CommonAsset.backgroundBlue)
        case .lightGrayBlue:
            Image(asset: CommonAsset.backgroundLight)
        }
    }

    public var preview: Image {
        switch self {
        case .blueGray:
            Image(asset: CommonAsset.previewBlueGray)
        case .whiteGreen:
            Image(asset: CommonAsset.previewWhiteGreen)
        case .blackBlue:
            Image(asset: CommonAsset.previewBlackBlue)
        case .grayBlack:
            Image(asset: CommonAsset.previewGrayBlack)
        case .blueBlack:
            Image(asset: CommonAsset.previewBlueBlack)
        case .blackGray:
            Image(asset: CommonAsset.previewBlackGray)
        case .purpleClear:
            Image(asset: CommonAsset.previewPurpleClear)
        case .blueClear:
            Image(asset: CommonAsset.previewBlueClear)
        case .blueGreen:
            Image(asset: CommonAsset.previewBlueGreen)
        case .lightGrayBlue:
            Image(asset: CommonAsset.previewLightGrayBlue)
        }
    }

    // MARK: 선수명
    public var nameFieldBackgroundColor: Color {
        switch self {
        case .blueGray, .blueBlack, .blackGray, .blackBlue, .grayBlack:
            return Color.colorBlack
        case .blueGreen, .lightGrayBlue, .whiteGreen, .purpleClear, .blueClear:
            return Color.colorWhite
        }
    }

    public var nameFieldTextColor: Color {
        switch self {
        case .blueGray, .blueBlack, .blackGray, .blackBlue, .grayBlack:
            return Color.colorWhite
        case .blueGreen, .lightGrayBlue, .whiteGreen, .purpleClear, .blueClear:
            return Color.colorBlack
        }
    }

    public var textColor: Color {
        switch self {
        case .blueGray, .blueGreen, .blueBlack, .blackGray, .blackBlue, .purpleClear, .blueClear:
            Color.colorWhite
        case .grayBlack, .lightGrayBlue, .whiteGreen:
            Color.colorBlack
        }
    }

    public var share: Image {
        switch self {
        case .blueGray:
            Image(asset: CommonAsset.shareGray)
        case .whiteGreen:
            Image(asset: CommonAsset.shareGreen)
        case .blackBlue:
            Image(asset: CommonAsset.shareBlue)
        case .grayBlack:
            Image(asset: CommonAsset.shareBlack)
        case .blueBlack:
            Image(asset: CommonAsset.shareBlueBlack)
        case .blackGray:
            Image(asset: CommonAsset.shareBlackGray)
        case .purpleClear:
            Image(asset: CommonAsset.sharePurpleClear)
        case .blueClear:
            Image(asset: CommonAsset.shareBlueClear)
        case .blueGreen:
            Image(asset: CommonAsset.shareBlueGreen)
        case .lightGrayBlue:
            Image(asset: CommonAsset.shareLightGrayBlue)
        }
    }

    public var goalkeeperPrimaryColor: UniformColor {
        switch self {
        case .blueGray:
            UniformColor(red: 136 / 255, green: 240 / 255, blue: 136 / 255)
        case .blueGreen:
            UniformColor(red: 255 / 255, green: 247 / 255, blue: 67 / 255)
        case .blueBlack:
            UniformColor(red: 253 / 255, green: 137 / 255, blue: 200 / 255)
        case .blackGray:
            UniformColor(red: 136 / 255, green: 240 / 255, blue: 133 / 255)
        case .blackBlue:
            UniformColor(red: 136 / 255, green: 240 / 255, blue: 133 / 255)
        case .grayBlack:
            UniformColor(red: 136 / 255, green: 240 / 255, blue: 133 / 255)
        case .lightGrayBlue:
            UniformColor(red: 168 / 255, green: 228 / 255, blue: 246 / 255)
        case .whiteGreen:
            UniformColor(red: 255 / 255, green: 247 / 255, blue: 67 / 255)
        case .purpleClear:
            UniformColor(red: 253 / 255, green: 137 / 255, blue: 200 / 255)
        case .blueClear:
            UniformColor(red: 168 / 255, green: 228 / 255, blue: 246 / 255)
        }
    }

    public var goalkeeperSecondaryColor: UniformColor {
        UniformColor(red: 0.6, green: 0.6, blue: 0.6)
    }
}
