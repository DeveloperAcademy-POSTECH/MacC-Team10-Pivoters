//
//  UniformObservable.swift
//  Feature
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

import Core
import Common

@Observable
public final class UniformObservable {

    var lineup: LineupV1
    var uniforms: [Uniform] = Uniform.uniformArray

    init(lineup: LineupV1) {
        self.lineup = lineup
        sortUniforms()
    }

    func sortUniforms() {
        uniforms.sort(by: { pre, _ in
            if pre.rawValue == self.lineup.selectedUniform {
                return true
            }
            return false
        })
    }

    func updateUniformColor(colors: [String], colorSequence: ColorSequence) {
        let colorsTypeDouble = stringToDouble(colors: colors)
        switch colorSequence {
        case .primaryColor:
            self.lineup.primaryColor.red = colorsTypeDouble[0]
            self.lineup.primaryColor.green = colorsTypeDouble[1]
            self.lineup.primaryColor.blue = colorsTypeDouble[2]
        case .secondaryColor:
            self.lineup.secondaryColor.red = colorsTypeDouble[0]
            self.lineup.secondaryColor.green = colorsTypeDouble[1]
            self.lineup.secondaryColor.blue = colorsTypeDouble[2]
        }
    }

    func stringToDouble(colors: [String]) -> [Double] {
        var colorsTypeDouble: [Double] = []
        for index in 1..<4 {
            colorsTypeDouble.append(Double(colors[index]) ?? 0.1)
        }
        return colorsTypeDouble
    }
}

enum ColorSequence {
    case primaryColor
    case secondaryColor
}
