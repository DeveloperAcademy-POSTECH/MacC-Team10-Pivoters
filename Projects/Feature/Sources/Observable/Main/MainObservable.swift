//
//  MainObservable.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import UIKit

@Observable
public final class MainObservable {
    public var isSharing: Bool // 공유 상태 여뷰
    public var isLoading: Bool // 초기 로딩 상태 여뷰
    public var isShowTeamSheet: Bool // 팀 교체 시트 표시 여뷰
    public var isShowEditSheet: Bool // 편집 시트 표시 여부
    public var currentIndex: Int // 현재 인덱스 값: carousel
    public var editSheetOffset: CGFloat // 편집 시트 오프셋
    public var editSheetIndicatorOffset: CGFloat // "밀어서 편집하기" 섹션 오프셋

    public init() {
        self.isSharing = false
        self.isLoading = true
        self.isShowTeamSheet = false
        self.isShowEditSheet = false
        self.currentIndex = 0
        self.editSheetOffset = CGFloat.zero
        self.editSheetIndicatorOffset = CGFloat.zero
    }
}
