//
//  OffsetValue.swift
//  Core
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
public final class OffsetValue {
    public var draggedOffset: CGSize
    public var accumulatedOffset: CGSize

    public init(draggedOffset: CGSize, accumulatedOffset: CGSize) {
        self.draggedOffset = draggedOffset
        self.accumulatedOffset = accumulatedOffset
    }
}
