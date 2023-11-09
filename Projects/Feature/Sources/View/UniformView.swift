//
//  UniformView.swift
//  Feature
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

public struct UniformView: View {

    @State var observable: UniformObservable
    @State var primaryColor: Color
    @State var secondaryColor: Color
    let rows = [GridItem(.fixed(100))]

    public init(observable: UniformObservable) {
        self.observable = observable
        self.primaryColor = Color(.sRGB,
                                  red: observable.lineup.primaryColor.red,
                                  green: observable.lineup.primaryColor.green,
                                  blue: observable.lineup.primaryColor.blue)
        self.secondaryColor = Color(.sRGB,
                                    red: observable.lineup.secondaryColor.red,
                                    green: observable.lineup.secondaryColor.green,
                                    blue: observable.lineup.secondaryColor.blue)
    }

    public var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(observable.uniforms, id: \.self) { uniform in
                        OverlapUniform(uniformSize: 80,
                                       uniform: uniform,
                                       uniformColors: [observable.lineup.primaryColor,
                                                       observable.lineup.secondaryColor])
                        .padding(.trailing, 22)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 100)
            List {
                ColorPicker("Uniform Color", selection: $primaryColor, supportsOpacity: false)
                ColorPicker("Secondary Color", selection: $secondaryColor, supportsOpacity: false)
            }
            .scrollContentBackground(.hidden)

        }
        .background(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        .onChange(of: primaryColor) {
            let colors: [String] =
            primaryColor
                .description
                .split(separator: " ")
                .map {
                    String($0)
                }
            observable.updateUniformColor(colors: colors, colorSequence: .primaryColor)
        }
        .onChange(of: secondaryColor) {
            let colors: [String] =
            secondaryColor
                .description
                .split(separator: " ")
                .map {
                    String($0)
                }
            observable.updateUniformColor(colors: colors, colorSequence: .secondaryColor)
        }
    }
}
