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
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color(uiColor: .systemGray5))
                            .frame(width: 64, height: 64)
                            .overlay {
                                overlapUniform(uniform: uniform,
                                               uniformSize: 52,
                                               isGoalkeeper: false)
                                if observable.lineup.selectedUniform == uniform.rawValue {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.colorBlue, lineWidth: 1.5)
                                        .padding(1)
                                    VStack {
                                        Spacer()
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(Color(uiColor: .systemGray5))
                                            .frame(width: 16, height: 16)
                                            .offset(y: 8)
                                            .overlay {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundStyle(Color.colorBlue)
                                                    .frame(width: 16, height: 16)
                                                    .offset(y: 8)
                                            }
                                    }
                                }
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 80)
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .foregroundColor(Color(uiColor: .systemGray5))
                .opacity(0.4)
                .frame(height: 90)
                .overlay {
                    VStack {
                        ColorPicker(String(localized: "Main Color"), 
                                    selection: $primaryColor,
                                    supportsOpacity: false)
                            .font(.Pretendard.semiBold14.font)
                            .padding(.horizontal)
                        Divider()
                        ColorPicker(String(localized: "Sub Color"), 
                                    selection: $secondaryColor,
                                    supportsOpacity: false)
                            .padding(.horizontal)
                            .font(.Pretendard.semiBold14.font)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
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

    func overlapUniform(uniform: Uniform,
                        uniformSize: CGFloat,
                        isGoalkeeper: Bool) -> some View {
        return OverlapUniform(uniform: uniform,
                              uniformSize: uniformSize,
                              primaryColor: observable.lineup.primaryColor,
                              secondaryColor: observable.lineup.secondaryColor,
                              isGoalkeeper: isGoalkeeper)
        .onTapGesture {
            observable.lineup.selectedUniform = uniform.rawValue
        }
    }
}
