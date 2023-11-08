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
    private var someTeam = Team(id: UUID(), teamName: "Newcastle United", subTitle: "2023-2024 Season", lineup: [])
    // 추후 model에서 반영 예정
    private var tintColor = Color.black

    public var body: some View {
        NavigationView {
            ZStack {
                FieldView()
                    .blur(radius: isSharing ? 10 : 0)
                TeamInfo(team: someTeam)
                    .blur(radius: isSharing ? 10 : 0)
                if isSharing {
                    ShareImage()
                        .padding(.bottom, 400)
                }
            }
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

// 공유 버튼
struct ShareButton: View {
    @Binding var isSharing: Bool
    @State private var snapshotImage: UIImage?

    private func captureAndShareSnapshot() {
        self.snapshotImage = ShareImage().snapshot()
        if let image = self.snapshotImage {
            print("스냅숏 이미지 확인.")
            self.isSharing = true
            print("Image size: \(image.size)")

            let item = ImageMetadataProvider(placeholderItem: snapshotImage!)
            self.showShareSheet(with: [item], isSharing: $isSharing)
        } else {
            print("Error ::: ")
        }
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

// 포메이션 텍스트
struct FormationText: View {

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("3-4-3")
                .font(.system(size: 12, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
        }
        .padding(.top, 10)
    }
}

// 팀 정보 텍스트 섹션
struct TeamInfo: View {
    let team: Team

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 14))
                    .foregroundColor(.clear)
                Text(team.teamName)
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                Button {
                    print("tap!!")
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 14))
                }
                .padding(.bottom, 3)
            }
            Text(team.subTitle)
                .font(.system(size: 10))
            FormationText()
            Spacer()
        }
        .padding(.top, 200)
    }
}

// 필드 뷰, 딴의 작업물로 대체 예정
struct FieldView: View {

    var body: some View {
        VStack {
            Color.blue.opacity(0.3)
                .frame(height: 600)
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
