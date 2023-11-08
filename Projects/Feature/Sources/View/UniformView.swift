//
//  UniformView.swift
//  Feature
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

public struct UniformView: View {

    @State private var observable = UniformObservable()
    @State var tempColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    public init() { }

    public var body: some View {
        VStack {
            Image(asset: CommonAsset.uniform)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(observable.lineup.primaryColor)
                .frame(width: 100, height: 100)
                .overlay {
                    Image(asset: CommonAsset.tempsvg)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(tempColor)
                        .frame(width: 30, height: 30)
                }

            ColorPicker(selection: $observable.lineup.primaryColor, supportsOpacity: false) {
                Text("Uniform Color")
            }
            .padding()
            ColorPicker(selection: $tempColor, supportsOpacity: false) {
                Text("Secondary Color")
            }
            .padding()
            Spacer()
        }
    }
}
