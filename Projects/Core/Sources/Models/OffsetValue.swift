//
//  OffsetValue.swift
//  Core
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public final class OffsetValue {
    public var draggedOffset: CGSize
    public var accumulatedOffset: CGSize
    
    init(draggedOffset: CGSize = CGSize.zero, accumulatedOffset: CGSize = CGSize.zero) {
        self.draggedOffset = draggedOffset
        self.accumulatedOffset = accumulatedOffset
    }
}
