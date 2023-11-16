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

    @State private var isSharing = false
    @State private var isLoading = true
    @State private var isShowTeamSheet = false
    @State private var isShowEditSheet = false
    @State private var currentIndex: Int = 0
    @State private var editSheetOffset = CGFloat(0)
    @State private var editSheetIndicatorOffset = CGFloat(0)

    @State var fieldObservable = FieldObservable()

    @State private var observable: TeamSelectObservable

    @MainActor
    public init() {
        let observable = TeamSelectObservable(modelContext: teamContainer.mainContext)
        _observable = State(initialValue: observable)
    }

    // 추후 model에서 반영 예정
    private var tintColor = Color.white

    public var body: some View {
        NavigationView {
            ZStack {
                FieldCarousel(isShowEditSheet: $isShowEditSheet,
                              currentIndex: $currentIndex,
                              editSheetIndicatorOffset:
                                $editSheetIndicatorOffset,
                              editSheetOffset: $editSheetOffset,
                              isShowTeamSheet: $isShowTeamSheet, isSharing: $isSharing)
                .environment(fieldObservable)
                TeamChangeButton(isShowingSheet: $isShowTeamSheet,
                                 isShowEditSheet: $isShowEditSheet,
                                 observable: observable, theme: fieldObservable.theme)
                TeamInfo(observable: $observable,
                         isSharing: $isSharing,
                         isShowTeamSheet: $isShowTeamSheet,
                         isShowEditSheet: $isShowEditSheet, theme: fieldObservable.theme)
                ShareImage(isSharing: $isSharing)
                FieldCarouselButton(currentIndex: $currentIndex,
                                    isShowEditSheet: $isShowEditSheet,
                                    isShowTeamSheet: $isShowTeamSheet,
                                    isSharing: $isSharing, theme: fieldObservable.theme)
                ShareButton(isSharing: $isSharing,
                            isShowEditSheet: $isShowEditSheet, theme: fieldObservable.theme)
                LaunchScreenView(isLoading: $isLoading).transition(.opacity).zIndex(1)
                EditSheetModalSection(isShowEditSheet: $isShowEditSheet,
                                      editSheetOffset: $editSheetOffset)
                .environment(fieldObservable)
                EditSheetIndicator(isShowEditSheet: $isShowEditSheet,
                                   isShowTeamSheet: $isShowTeamSheet,
                                   editSheetIndicatorOffset: $editSheetIndicatorOffset, theme: fieldObservable.theme)
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
                        isLoading.toggle()
                        isShowEditSheet = isLoading
                    }
                })
            }
        }
        .tint(tintColor)
    }
}

// 편집 시트 모달 섹션
struct EditSheetModalSection: View {
    @Binding var isShowEditSheet: Bool
    @Binding var editSheetOffset: CGFloat
    let maxDragHeight: CGFloat = 200

    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        if isShowEditSheet {
            VStack {
                Spacer()
                ModalSegmentedView()
                    .environment(fieldObservable)
                    .animation(.easeInOut, value: isShowEditSheet)
                    .offset(y: editSheetOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    editSheetOffset = value.translation.height
                                }
                            }
                            .onEnded { _ in
                                if editSheetOffset > 100 {
                                    isShowEditSheet = false
                                }
                                editSheetOffset = 0
                            }
                    )
            }
        }
    }
}

// 필드 캐러셀
struct FieldCarousel: View {
    @Binding var isShowEditSheet: Bool
    @Binding var currentIndex: Int
    @Binding var editSheetIndicatorOffset: CGFloat
    @Binding var editSheetOffset: CGFloat
    @Binding var isShowTeamSheet: Bool
    @Binding var isSharing: Bool

    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        Carousel(pageCount: 3,
                 visibleEdgeSpace: -120,
                 spacing: -30,
                 currentIndex: $currentIndex) { _ in
            VStack {
                Spacer()
                FieldView()
                    .environment(fieldObservable)
            }
        }
                 .padding(.bottom, isShowEditSheet ? 330 : 20)
                 .offset(y: editSheetIndicatorOffset)
                 .offset(y: editSheetOffset)
                 .blur(radius: (isSharing || isShowTeamSheet) ? 10 : 0)
                 .animation(.easeInOut(duration: 0.4), value: isShowEditSheet)
    }
}

// "밀어올려서 편집하기" 전환 영역
struct EditSheetIndicator: View {
    @Binding var isShowEditSheet: Bool
    @Binding var isShowTeamSheet: Bool
    @Binding var editSheetIndicatorOffset: CGFloat
    var theme: Theme

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let maxDragHeight = screenHeight / 3
            if !isShowEditSheet {
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
                .offset(y: editSheetIndicatorOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height < 0 && editSheetIndicatorOffset > -maxDragHeight {
                                editSheetIndicatorOffset = max(value.translation.height, -maxDragHeight)
                            }
                        }
                        .onEnded { _ in
                            if editSheetIndicatorOffset <= -maxDragHeight / 2 {
                                isShowEditSheet = true
                            }
                            editSheetIndicatorOffset = 0
                        }
                )
                .blur(radius: isShowTeamSheet ? 10 : 0)
            }
        }
    }
}

// 필드 캐러셀 버튼
struct FieldCarouselButton: View {
    @Binding var currentIndex: Int
    @Binding var isShowEditSheet: Bool
    @Binding var isShowTeamSheet: Bool
    @Binding var isSharing: Bool
    var theme: Theme

    var body: some View {
        if !isShowEditSheet {
            VStack {
                HStack {
                    Button(action: {
                        currentIndex = max(currentIndex - 1, 0)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(theme.textColor)
                            .font(.system(size: 20))
                            .opacity(currentIndex == 0 ? 0.3 : 1)
                    })
                    .padding()
                    .contentShape(Rectangle())
                    Spacer()
                    Button(action: {
                        currentIndex = min(currentIndex + 1, 2)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(theme.textColor)
                            .font(.system(size: 20))
                            .opacity(currentIndex == 2 ? 0.3 : 1)
                    })
                    .padding()
                    .contentShape(Rectangle())
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .blur(radius: (isSharing || isShowTeamSheet) ? 10 : 0)
        }
    }
}

// 팀 변경 버튼
struct TeamChangeButton: View {
    @Binding var isShowingSheet: Bool
    @Binding var isShowEditSheet: Bool
    var observable: TeamSelectObservable
    var theme: Theme

    var body: some View {
        if !isShowEditSheet {
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
                    .sheet(isPresented: $isShowingSheet) {
                        TeamSelectView(observable: observable)
                            .modelContainer(teamContainer)
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
}

// 공유 버튼
struct ShareButton: View {
    @Binding var isSharing: Bool
    @Binding var isShowEditSheet: Bool
    @State private var snapshotImage: UIImage?
    var theme: Theme

    private func captureAndShareSnapshot() {
        snapshotImage = ShareImage(isSharing: $isSharing).snapshot()
        isSharing = true
        let metaData = ImageMetadataProvider(placeholderItem: snapshotImage!)
        showShareSheet(with: [metaData], isSharing: $isSharing)
    }

    var body: some View {

        if isShowEditSheet {
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
    @Binding var observable: TeamSelectObservable
    @Binding var isSharing: Bool
    @Binding var isShowTeamSheet: Bool
    @Binding var isShowEditSheet: Bool
    var theme: Theme

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("이하이")
                    .font(.system(size: isShowEditSheet ? 22 : 18, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(theme.textColor)
                if isShowEditSheet {
                    Spacer()
                }
            }
            .padding(.bottom, 5)
            HStack(alignment: .center) {
                Text("이하이")
                    .font(.system(size: 10))
                    .foregroundStyle(theme.textColor)
                if isShowEditSheet {
                    Spacer()
                }
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.top, isShowEditSheet ? 95 : 137)
        .padding(.leading, isShowEditSheet ? 24 : 0)
        .blur(radius: (isSharing || isShowTeamSheet) ? 10 : 0)
        .animation(.easeInOut(duration: 0.3), value: isShowEditSheet)
    }
}

#Preview {
    MainView()
}
