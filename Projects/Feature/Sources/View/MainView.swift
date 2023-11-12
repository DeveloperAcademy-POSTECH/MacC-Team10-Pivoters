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
    @State private var isShowingSheet = false
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
                TeamChangeButton(isShowingSheet: $isShowingSheet)
                TeamInfo(team: someTeam)
                    .blur(radius: (isSharing || isShowingSheet) ? 10 : 0)
                // ShareImage 표시 -> 편집 화면에서 활용
                if isSharing {
                    ShareImage()
                        .padding(.bottom, 400)
                }
                FieldCarousel(pageCount: 3,
                              visibleEdgeSpace: -120,
                              spacing: -30,
                              currentIndex: $currentIndex) { _ in
                    VStack {
                        Spacer()
                        FieldView(observable: FieldObservable())
                    }
                }
                              .frame(maxHeight: 600)
                              .blur(radius: (isSharing || isShowingSheet) ? 10 : 0)
                FieldCarouselButton(currentIndex: $currentIndex)
                    .blur(radius: (isSharing || isShowingSheet) ? 10 : 0)
            }
            .background(
                Image(asset: CommonAsset.background1)
                    .resizable()
                    .scaledToFill()
                    .blur(radius: (isSharing || isShowingSheet) ? 10 : 0)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
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
                if currentIndex != 0 {
                    Button(action: {
                        currentIndex = max(currentIndex - 1, 0)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                    })
                    .padding()
                    .contentShape(Rectangle())
                }
                Spacer()
                if currentIndex != 2 {
                    Button(action: {
                        currentIndex = min(currentIndex + 1, 2)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                    })
                    .padding()
                    .contentShape(Rectangle())
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}

// 팀 변경 버튼
struct TeamChangeButton: View {
    @Binding var isShowingSheet: Bool

    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    isShowingSheet.toggle()
                }, label: {
                    if isShowingSheet {
                        VStack {
                            Image(systemName: "flag.2.crossed")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                            Text("팀 변경")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.black)
                        }
                        .padding(.all, 9)
                        .background(Color.white)
                        .clipShape(Circle())
                    }else {
                        VStack {
                            Image(systemName: "flag.2.crossed")
                                .font(.system(size: 20))
                            Text("팀 변경")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.white)
                        }
                    }
                })
                .sheet(isPresented: $isShowingSheet) {
                    TeamChangeModalView()
                }
                Spacer()
            }
            .padding(.top, 72)
            .padding(.leading, 19)
            Spacer()
        }
        .animation(.easeInOut, value: isShowingSheet)
    }
}

// 공유 버튼 -> 편집 화면으로 이동 예정
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
            .padding(.bottom, 5)
            Text(team.subTitle)
                .font(.system(size: 10))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.top, 137)
    }
}

#Preview {
    MainView()
}
