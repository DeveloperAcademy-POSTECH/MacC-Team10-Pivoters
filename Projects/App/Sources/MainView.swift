//
//  MainView.swift
//  App
//
//  Created by Ha Jong Myeong on 11/7/23.
//

import Core
import SwiftUI

struct MainView: View {
    private var someTeam = Team(id: UUID(), teamName: "Newcastle United", subTitle: "2023-2024 Season", lineup: [])
    // 추후 model에서 반영 예정
    private var tintColor = Color.black

    var body: some View {
        NavigationView {
            ZStack {
                FieldView()
                TeamInfo(team: someTeam)
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ShareButton()
                }
            }
        }
        .tint(tintColor)
    }
}

struct ShareButton: View {
    var body: some View {
        Button {
            print("tap!!")
        } label: {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 20))
        }
    }
}

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

struct FieldView: View {

    var body: some View {
        VStack {
            // 에셋으로 대체
            Color.blue.opacity(0.3)
                .frame(height: 600)
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
