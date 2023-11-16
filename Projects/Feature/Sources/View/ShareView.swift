//
//  ShareView.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI
import Core

public struct ShareView: View {
    @Binding var mainObservable: MainObservable
    @State var observable = TeamObservable()

    public var body: some View {
        VStack {
            ShareImage(isSharing: mainObservable.isSharing, lineup: observable.team.lineup)
            Spacer()
        }
    }
}

public struct ShareImage: View {
    var isSharing: Bool
    var lineup: [Lineup]

    public var body: some View {
        if isSharing {
            FieldView(observable: FieldObservable(lineup: lineup[0]))
        }
    }
}
