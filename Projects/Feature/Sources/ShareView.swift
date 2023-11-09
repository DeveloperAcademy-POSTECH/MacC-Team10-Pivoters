//
//  ShareView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import LinkPresentation

public struct ShareView: View {

    public init() {}

    public var body: some View {
        ShareImage()
    }
}

struct ShareImage: View {

    var body: some View {
        Color.red
            .frame(width: 200, height: 200)
    }
}
