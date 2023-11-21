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
    var primaryColor: UniformColor
    var secondaryColor: UniformColor
    var isSelected: Bool
    var isGoalkeeper: Bool

    var body: some View {
        ZStack {
            if isGoalkeeper {
                goalkeeperPlayer
            } else {
                fieldPlayer
            }
        }
    }

    @ViewBuilder
    var goalkeeperPlayer: some View {
        let primaryColor = Color(.sRGB,
                                 red: self.primaryColor.red,
                                 green: self.primaryColor.green,
                                 blue: self.primaryColor.blue)
        uniform.goalkeeperPrimary
            .resizable()
            .renderingMode(.template)
            .foregroundColor(primaryColor)
            .frame(width: uniformSize, height: uniformSize)

        if let secondary = uniform.goalkeeperSecondary {
            let secondaryColor = Color(.sRGB,
                                       red: self.secondaryColor.red,
                                       green: self.secondaryColor.green,
                                       blue: self.secondaryColor.blue)
            secondary
                .resizable()
                .renderingMode(.template)
                .foregroundColor(secondaryColor)
                .frame(width: uniformSize, height: uniformSize)
        }
        uniform.goalkeeperBorder
            .resizable()
            .frame(width: uniformSize, height: uniformSize)
    }

    @ViewBuilder
    var fieldPlayer: some View {
        let primaryColor = Color(.sRGB,
                                 red: self.primaryColor.red,
                                 green: self.primaryColor.green,
                                 blue: self.primaryColor.blue)
        uniform.primary
            .resizable()
            .renderingMode(.template)
            .foregroundColor(primaryColor)
            .frame(width: uniformSize, height: uniformSize)

        if let secondary = uniform.secondary {
            let secondaryColor = Color(.sRGB,
                                       red: self.secondaryColor.red,
                                       green: self.secondaryColor.green,
                                       blue: self.secondaryColor.blue)
            secondary
                .resizable()
                .renderingMode(.template)
                .foregroundColor(secondaryColor)
                .frame(width: uniformSize, height: uniformSize)
        }
        uniform.border
            .resizable()
            .frame(width: uniformSize, height: uniformSize)

        if isSelected {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: uniformSize / 2, height: uniformSize / 2)
        }
    }

}
