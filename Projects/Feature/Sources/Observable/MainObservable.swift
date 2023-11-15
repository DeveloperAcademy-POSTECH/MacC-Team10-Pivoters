//
//  MainObservable.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

@Observable
public final class MainObservable {
    public var isSharing: Bool
    public var isLoading: Bool
    public var isShowTeamSheet: Bool
    public var isShowEditSheet: Bool
    public var currentIndex: Int
    public var editSheetOffset: CGFloat
    public var editSheetIndicatorOffset: CGFloat

    public init() {
        self.isSharing = false
        self.isLoading = true
        self.isShowTeamSheet = false
        self.isShowEditSheet = false
        self.currentIndex = 0
        self.editSheetOffset = CGFloat(0)
        self.editSheetIndicatorOffset = CGFloat(0)
    }
}
