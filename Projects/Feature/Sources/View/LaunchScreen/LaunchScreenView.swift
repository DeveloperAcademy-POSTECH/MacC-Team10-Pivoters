//
//  LaunchScreenView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/13/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct LaunchScreenView: View {
    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            ZStack {
                Image(asset: CommonAsset.splash)
                    .resizable()
                    .scaledToFill()
                VStack {
                    Spacer()
                    Image(asset: CommonAsset.splashTitle)
                        .padding(.bottom, 140)
                }
            }
            .ignoresSafeArea()
        }
    }
}
