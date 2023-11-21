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
