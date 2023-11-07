//
//  FieldView.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common

struct FieldView: View {
    @State var observable: FieldObservable

    var body: some View {
        ZStack {
            Image(asset: CommonAsset.field)
            VStack {
                ForEach(observable.players) { player in
                    PlayerView(player: player)
                }
            }
        }
    }
}
