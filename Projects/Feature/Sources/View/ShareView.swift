//
//  ShareView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

public struct ShareView: View {
    @State private var isSharing = false
    
    public init() {}

    public var body: some View {
        ShareImage(isSharing: $isSharing)
    }
}

struct ShareImage: View {
    @Binding var isSharing: Bool

    var body: some View {
        if isSharing {
            Color.red
                .frame(width: 200, height: 200)
                .padding(.bottom, 400)
        }
    }
}
