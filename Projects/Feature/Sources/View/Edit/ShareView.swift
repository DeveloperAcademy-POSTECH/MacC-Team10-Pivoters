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
    @Binding var isSharing: Bool
    var team: TeamV1?
    var lineup: LineupV1
    @State private var snapshotImage: UIImage?

    public var body: some View {
        if isSharing {
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
                    self.snapshotImage = ShareImage(team: team,
                                                    isSharing: true,
                                                    lineup: lineup).snapshot()
                }
                Spacer()
            }
            .padding()
        }
    }
}

public struct ShareImage: View {
    var team: TeamV1?
    var isSharing: Bool
    var lineup: LineupV1
    let deviceHeight = UIScreen.main.bounds.height
    var players: [PlayerV1]

    init(team: TeamV1? = nil, isSharing: Bool, lineup: LineupV1) {
        self.team = team
        self.isSharing = isSharing
        self.lineup = lineup
        self.players = self.lineup.players.sorted { $0.number < $1.number }
    }

    public var body: some View {
        if isSharing {
            ZStack {
                Theme(rawValue: lineup.selectedTheme)?.share
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                VStack {
                    if let team = team {
                        Text("\(team.teamName)")
                            .font(.Pretendard.black16.font)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Theme(rawValue: lineup.selectedTheme)?.textColor ?? .black)
                            .padding(.bottom, 1)
                    }
                    Text("\(lineup.lineupName)")
                        .font(.Pretendard.subhead.font)
                        .foregroundStyle(Theme(rawValue: lineup.selectedTheme)?.textColor ?? .black)
                    Spacer()
                }
                .padding(.top, (deviceHeight <= 800) ? deviceHeight * 0.04 : deviceHeight * 0.022)
                ForEach(0..<lineup.selectedPlayType, id: \.hashValue) { index in
                    PlayerView(theme: Theme(rawValue: lineup.selectedTheme) ?? .blueGray,
                               player: players[index],
                               lineup: lineup,
                               index: 100)
                    .offset(CGSize(width: players[index].offset.draggedOffsetWidth,
                                   height: players[index].offset.draggedOffsetHeight))
                }
                .padding(.top, (deviceHeight <= 800) ? deviceHeight * 0.17 : deviceHeight * 0.08)
            }
        }
    }
}
