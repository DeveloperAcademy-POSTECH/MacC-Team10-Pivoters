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
    @State private var snapshotImage: UIImage?

    public var body: some View {
        if mainObservable.isSharing {
            VStack(alignment: .leading) {
                HStack {
                    if let image = snapshotImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 380, height: 310)
                .onAppear {
                    self.snapshotImage = ShareImage(mainObservable: $mainObservable, isSharing: true, lineup: observable.team.lineup).snapshot()
                }
            }
            .padding(.bottom, 470) // 추후 반응형으로 y축 위치 조정
        }
    }
}

public struct ShareImage: View {
    @Binding var mainObservable: MainObservable
    @State var observable = TeamObservable()
    var isSharing: Bool
    var lineup: [Lineup]

    public var body: some View {
        if isSharing {
            VStack {
                Text("\(observable.team.teamName)")
                    .font(.Pretendard.black16.font)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(observable.team.lineup[mainObservable.currentIndex].theme.textColor)
                    .padding(.bottom, 1)

                Text("\(observable.team.subTitle)")
                    .font(.Pretendard.subhead.font)
                    .foregroundStyle(observable.team.lineup[mainObservable.currentIndex].theme.textColor)
                VStack {
                    FieldView(observable: FieldObservable(lineup: lineup[0]))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 380, height: 310)
                        .clipShape(Rectangle())
                }
                Spacer()
            }
            .background(
                observable.team.lineup[mainObservable.currentIndex].theme.background)
        }
    }
}
