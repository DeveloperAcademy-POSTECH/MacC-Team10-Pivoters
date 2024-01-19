//
//  Offset.swift
//  Data
//
//  Created by 한지석 on 1/17/24.
//  Copyright © 2024 com.pivoters. All rights reserved.
//

import Foundation

public struct OffsetValue: Codable {

    public var draggedOffsetWidth: Double
    public var draggedOffsetHeight: Double
    public var accumulatedOffsetWidth: Double
    public var accumulatedOffsetHeight: Double

    public init(draggedOffsetWidth: Double,
                draggedOffsetHeight: Double,
                accumulatedOffsetWidth: Double,
                accumulatedOffsetHeight: Double) {
        self.draggedOffsetWidth = draggedOffsetWidth
        self.draggedOffsetHeight = draggedOffsetHeight
        self.accumulatedOffsetWidth = accumulatedOffsetWidth
        self.accumulatedOffsetHeight = accumulatedOffsetHeight
    }
}
