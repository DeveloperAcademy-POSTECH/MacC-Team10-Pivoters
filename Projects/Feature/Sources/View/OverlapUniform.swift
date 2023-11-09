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

    let uniform: Uniform
    let uniformSize: CGFloat
    var uniformColors: [UniformColor]
    var isSelected: Bool

    var body: some View {
        ZStack {
            uniform.assets[2]
                .resizable()
                .frame(width: uniformSize, height: uniformSize)
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
            if isSelected {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: uniformSize / 2, height: uniformSize / 2)
            }
        }
    }
}
