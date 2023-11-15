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

    @State var mainObservable = MainObservable()

    @State var fieldObservable = FieldObservable()

    public init() {}

    @StateObject private var observable = TeamObservable()
    // 추후 model에서 반영 예정
    private var tintColor = Color.white

    public var body: some View {
        NavigationView {
            ZStack {
                FieldCarousel(mainObservable: $mainObservable)
                .environment(fieldObservable)
                TeamChangeButton(mainObservable: $mainObservable, observable: observable, theme: fieldObservable.theme)
                TeamInfo(mainObservable: $mainObservable, observable: observable,
                         theme: fieldObservable.theme)
                ShareImage(isSharing: $mainObservable.isSharing)
                FieldCarouselButton(mainObservable: $mainObservable, theme: fieldObservable.theme)
                ShareButton(mainObservable: $mainObservable, theme: fieldObservable.theme)
                LaunchScreenView(isLoading: $mainObservable.isLoading).transition(.opacity).zIndex(1)
                EditSheetModalSection(mainObservable: $mainObservable)
                .environment(fieldObservable)
                EditSheetIndicator(mainObservable: $mainObservable, theme: fieldObservable.theme)
            }
            .background(
                fieldObservable.theme.background
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation {
                        mainObservable.isLoading.toggle()
                        mainObservable.isShowEditSheet = mainObservable.isLoading
                    }
                })
            }
        }
        .tint(tintColor)
    }
}

// 편집 시트 모달 섹션
struct EditSheetModalSection: View {
    @Binding var mainObservable: MainObservable
    let maxDragHeight: CGFloat = 200

    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        if mainObservable.isShowEditSheet {
            VStack {
                Spacer()
                ModalSegmentedView()
                    .environment(fieldObservable)
                    .animation(.easeInOut, value: mainObservable.isShowEditSheet)
                    .offset(y: mainObservable.editSheetOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    mainObservable.editSheetOffset = value.translation.height
                                }
                            }
                            .onEnded { _ in
                                if mainObservable.editSheetOffset > 100 {
                                    mainObservable.isShowEditSheet = false
                                }
                                mainObservable.editSheetOffset = 0
                            }
                    )
            }
        }
    }
}

// 필드 캐러셀
struct FieldCarousel: View {
    @Binding var mainObservable: MainObservable
    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        Carousel(pageCount: 3,
                 visibleEdgeSpace: -120,
                 spacing: -30,
                 currentIndex: $mainObservable.currentIndex) { _ in
            VStack {
                Spacer()
                FieldView()
                    .environment(fieldObservable)
            }
        }
                 .padding(.bottom, mainObservable.isShowEditSheet ? 330 : 20)
                 .offset(y: mainObservable.editSheetIndicatorOffset)
                 .offset(y: mainObservable.editSheetOffset)
                 .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
                 .animation(.easeInOut(duration: 0.4), value: mainObservable.isShowEditSheet)
    }
}

// "밀어올려서 편집하기" 전환 영역
struct EditSheetIndicator: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let maxDragHeight = screenHeight / 3
            if !mainObservable.isShowEditSheet {
                VStack {
                    Spacer()
                    VStack {
                        Image(systemName: "arrowshape.up")
                            .foregroundStyle(theme.textColor)
                            .padding(.bottom, 10)
                        Text("밀어올려서 편집하기")
                            .foregroundStyle(theme.textColor)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 136)
                }
                .offset(y: mainObservable.editSheetIndicatorOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height < 0 && mainObservable.editSheetIndicatorOffset > -maxDragHeight {
                                mainObservable.editSheetIndicatorOffset = max(value.translation.height, -maxDragHeight)
                            }
                        }
                        .onEnded { _ in
                            if mainObservable.editSheetIndicatorOffset <= -maxDragHeight / 2 {
                                mainObservable.isShowEditSheet = true
                            }
                            mainObservable.editSheetIndicatorOffset = 0
                        }
                )
                .blur(radius: mainObservable.isShowTeamSheet ? 10 : 0)
            }
        }
    }
}

// 필드 캐러셀 버튼
struct FieldCarouselButton: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    var body: some View {

        if !mainObservable.isShowEditSheet {
            VStack {
                HStack {
                    Button(action: {
                        mainObservable.currentIndex = max(mainObservable.currentIndex - 1, 0)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(theme.textColor)
                            .font(.system(size: 20))
                            .opacity(mainObservable.currentIndex == 0 ? 0.3 : 1)
                    })
                    .padding()
                    .contentShape(Rectangle())
                    Spacer()
                    Button(action: {
                        mainObservable.currentIndex = min( mainObservable.currentIndex + 1, 2)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(theme.textColor)
                            .font(.system(size: 20))
                            .opacity( mainObservable.currentIndex == 2 ? 0.3 : 1)
                    })
                    .padding()
                    .contentShape(Rectangle())
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .blur(radius: ( mainObservable.isSharing ||  mainObservable.isShowTeamSheet) ? 10 : 0)
        }
    }
}

// 팀 변경 버튼
struct TeamChangeButton: View {
    @Binding var mainObservable: MainObservable
    var observable: TeamObservable
    var theme: Theme

    var body: some View {
        if !mainObservable.isShowEditSheet {
            HStack {
                VStack {
                    Button(action: {
                        mainObservable.isShowTeamSheet.toggle()
                    }, label: {
                        if  mainObservable.isShowTeamSheet {
                            VStack {
                                Image(systemName: "flag.2.crossed")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 20))
                                Text("팀 변경")
                                    .font(.system(size: 10))
                                    .foregroundStyle(theme.textColor)
                            }
                            .padding(.all, 9)
                            .background(Color.white)
                            .clipShape(Circle())
                        } else {
                            VStack {
                                Image(systemName: "flag.2.crossed")
                                    .font(.system(size: 20))
                                    .foregroundStyle(theme.textColor)
                                Text("팀 변경")
                                    .font(.system(size: 10))
                                    .foregroundStyle(Color.white)
                                    .foregroundStyle(theme.textColor)
                            }
                        }
                    })
                    .sheet(isPresented: $mainObservable.isShowTeamSheet) {
                        TeamChangeModalView(teamObservable: observable)
                    }
                    Spacer()
                }
                .padding(.top, 72)
                .padding(.leading, 19)
                Spacer()
            }
            .animation(.easeInOut, value:  mainObservable.isShowTeamSheet)
        }
    }
}

// 공유 버튼
struct ShareButton: View {
    @Binding var mainObservable: MainObservable
    @State private var snapshotImage: UIImage?
    var theme: Theme

    private func captureAndShareSnapshot() {
        snapshotImage = ShareImage(isSharing: $mainObservable.isSharing).snapshot()
        mainObservable.isSharing = true
        let metaData = ImageMetadataProvider(placeholderItem: snapshotImage!)
        showShareSheet(with: [metaData], isSharing: $mainObservable.isSharing)
    }

    var body: some View {

        if mainObservable.isShowEditSheet {
            HStack {
                Spacer()
                VStack {
                    Button {
                        captureAndShareSnapshot()
                    } label: {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                                .foregroundStyle(theme.textColor)
                            Text("공유하기")
                                .font(.system(size: 10))
                                .foregroundStyle(theme.textColor)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.top, 72)
            .padding(.trailing, 19)
        }
    }
}

// 팀 정보 텍스트 섹션
struct TeamInfo: View {
    @Binding var mainObservable: MainObservable
    @ObservedObject var observable: TeamObservable
    var theme: Theme

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(observable.currentTeam.teamName)
                    .font(.system(size: mainObservable.isShowEditSheet ? 22 : 18, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(theme.textColor)
                if mainObservable.isShowEditSheet {
                    Spacer()
                }
            }
            .padding(.bottom, 5)
            HStack(alignment: .center) {
                Text(observable.currentTeam.subTitle)
                    .font(.system(size: 10))
                    .foregroundStyle(theme.textColor)
                if mainObservable.isShowEditSheet {
                    Spacer()
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.top, mainObservable.isShowEditSheet ? 95 : 137)
        .padding(.leading, mainObservable.isShowEditSheet ? 24 : 0)
        .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
        .animation(.easeInOut(duration: 0.3), value: mainObservable.isShowEditSheet)
    }
}

#Preview {
    MainView()
}
