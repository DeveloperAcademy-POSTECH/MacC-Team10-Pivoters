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

struct UniformView: View {

    @State var observable: UniformObservable
    @State var primaryColor: Color
    @State var secondaryColor: Color
    @State var selectedUniform: Uniform = .basic
    @State var isPresented: Bool = false
    let rows = [GridItem(.fixed(100))]

    init(observable: UniformObservable) {
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

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows) {
                    ForEach(observable.uniforms, id: \.self) { uniform in
                        overlapUniform(uniform: uniform,
                                       uniformSize: 80,
                                       isSelected: selectedUniform == uniform ? true : false)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 100)
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .foregroundStyle(Color.gray)
                .opacity(0.4)
                .frame(height: 90)
                .overlay {
                    VStack {
                        ColorPicker("메인 컬러", selection: $primaryColor, supportsOpacity: false)
                            .padding(.horizontal)
                        Divider()
                        ColorPicker("서브 컬러", selection: $secondaryColor, supportsOpacity: false)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
            Spacer()
        }
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

    func overlapUniform(uniform: Uniform, uniformSize: CGFloat, isSelected: Bool) -> some View {
        return OverlapUniform(uniform: uniform,
                              uniformSize: 80,
                              uniformColors: [observable.lineup.primaryColor,
                                              observable.lineup.secondaryColor],
                              isSelected: isSelected)
        .padding(.trailing, 22)
        .opacity(isSelected ? 0.7 : 1)
        .onTapGesture {
            selectedUniform = uniform
        }
    }
}