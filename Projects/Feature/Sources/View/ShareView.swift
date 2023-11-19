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
import Common

public struct ShareView: View {
    @Binding var mainObservable: MainObservable
    var team: Team
    @State private var snapshotImage: UIImage?

    public var body: some View {
        if mainObservable.isSharing {
            VStack {
                HStack {
                    if let image = snapshotImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 7 / 9)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .onAppear {
                    self.snapshotImage = ShareImage(mainObservable: $mainObservable, team: team,
                                                    isSharing: true,
                                                    lineup: team.lineup).snapshot()
                }
                Spacer()
            }
            .padding()
        }
    }
}

public struct ShareImage: View {
    @Binding var mainObservable: MainObservable
    var team: Team
    var isSharing: Bool
    var lineup: [Lineup]

    public var body: some View {
        if isSharing {
            ZStack {
                Image(asset: CommonAsset.shareBlue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.width)
                    .offset(y: -20)
                VStack {
                    Text("\(team.teamName)")
                        .font(.Pretendard.black16.font)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(team.lineup[mainObservable.currentIndex].theme.textColor)
                        .padding(.bottom, 1)
                    Text("\(team.subTitle)")
                        .font(.Pretendard.subhead.font)
                        .foregroundStyle(team.lineup[mainObservable.currentIndex].theme.textColor)
                    Spacer()
                }
                .padding(.top, 30)
                ForEach(0..<lineup[0].formation.rawValue, id: \.hashValue) { index in
                    if lineup[0].players[index].isGoalkeeper {
                        PlayerView(theme: lineup[0].theme,
                                   player: lineup[0].players[index])
                        .offset(lineup[0].players[index].offset.draggedOffset)
                    } else {
                        PlayerView(theme: lineup[0].theme,
                                   player: lineup[0].players[index])
                        .offset(lineup[0].players[index].offset.draggedOffset)
                    }
                }
                .offset(y: 40) // 추후 반응형으로 위치 조정
            }
        }
    }
}
