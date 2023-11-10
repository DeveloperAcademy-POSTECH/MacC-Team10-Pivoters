//
//  MainView.swift
//  App
//
//  Created by Ha Jong Myeong on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Core
import Common
import SwiftUI

public struct MainView: View {

    public init() {}

    @State private var isSharing = false
    @State private var currentIndex: Int = 0

    private var someTeam = Team(id: UUID(),
                                teamName: "울산현대 FC",
                                subTitle: "2023 아시안 챔피언스리그 결승전 선발 멤버",
                                lineup: [])
    // 추후 model에서 반영 예정
    private var tintColor = Color.white

    public var body: some View {
        NavigationView {
            ZStack {
                FieldCarousel(pageCount: 3,
                              visibleEdgeSpace: -120,
                              spacing: -30,
                              currentIndex: $currentIndex) { _ in
                    VStack {
                        Spacer()
                        Image(asset: CommonAsset.field)
                    }
                }
                              .frame(maxHeight: 600)
                TeamInfo(team: someTeam)
                    .blur(radius: isSharing ? 10 : 0)
                if isSharing {
                    ShareImage()
                        .padding(.bottom, 400)
                }
                FieldCarouselButton(currentIndex: $currentIndex)

            }
            .background(
                Image(asset: CommonAsset.background1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: isSharing ? 10 : 0)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ShareButton(isSharing: $isSharing)
                        .blur(radius: isSharing ? 10 : 0)
                }
            }
        }
        .tint(tintColor)
    }
}

// 필드 캐러셀 버튼
struct FieldCarouselButton: View {
    @Binding var currentIndex: Int

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentIndex = max(currentIndex - 1, 0)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                })
                .padding()
                .contentShape(Rectangle())
                Spacer()
                Button(action: {
                    currentIndex = min(currentIndex + 1, 2)
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                })
                .padding()
                .contentShape(Rectangle())
            }
            .padding(.horizontal)
        }
    }
}

// 공유 버튼
struct ShareButton: View {
    @Binding var isSharing: Bool
    @State private var snapshotImage: UIImage?

    private func captureAndShareSnapshot() {
        snapshotImage = ShareImage().snapshot()
        isSharing = true
        let metaData = ImageMetadataProvider(placeholderItem: snapshotImage!)
        showShareSheet(with: [metaData], isSharing: $isSharing)
    }

    var body: some View {
        VStack {
            Button {
                isSharing = true
                captureAndShareSnapshot()
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
            }
        }
    }
}

// 팀 정보 텍스트 섹션
struct TeamInfo: View {
    let team: Team

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(team.teamName)
                    .font(.system(size: 18, weight: .bold))
                    .multilineTextAlignment(.center)
            }
            Text(team.subTitle)
                .font(.system(size: 10))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.top, 200)
    }
}

#Preview {
    MainView()
}
