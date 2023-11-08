//
//  Uniform.swift
//  Feature
//
//  Created by 한지석 on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

struct OverlapUniform: View {

    let uniformSize: CGFloat
    let uniform: Uniform
    var uniformColors: [UniformColor]

    var body: some View {
        ZStack {
            ForEach(0..<2) { index in
                let color = Color(.sRGB,
                                  red: uniformColors[index].red,
                                  green: uniformColors[index].green,
                                  blue: uniformColors[index].blue)
                uniform.assets[index]
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(color)
                    .frame(width: uniformSize, height: uniformSize)
            }
            uniform.assets[2]
                .resizable()
                .frame(width: uniformSize, height: uniformSize)
        }
    }
}
