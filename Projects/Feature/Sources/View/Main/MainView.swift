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
import SwiftData

public struct MainView: View {
    @State var mainObservable = MainObservable()
    @State var observable: TeamObservable

    @AppStorage("editType") var editType: EditType = .management

    @MainActor
    public init(modelContext: ModelContext) {
        let observable = TeamObservable(modelContext: modelContext)
        _observable = State(initialValue: observable)
    }

    public var body: some View {
        ZStack {
            // MARK: 런치 스크린
            if mainObservable.isLoading {
                LaunchScreenView()
                    .transition(.opacity)
                    .zIndex(1)
            }

            // MARK: 공유 버튼 클릭 시 Preview
            ShareView(isSharing: $mainObservable.isSharing,
                      team: observable.team,
                      lineup: observable.lineup[mainObservable.currentIndex]).zIndex(1)

            // MARK: 캐러셀 뷰
            VStack {
                Spacer()
                ZStack {
                    FieldCarousel(mainObservable: $mainObservable,
                                  lineup: observable.lineup,
                                  team: observable.team!, editType: $editType)
                    .padding(.bottom,
                             mainObservable.currentPresentationDetent == .height(CGFloat.defaultHeight) ?
                             CGFloat.defaultHeight : CGFloat.editHeight)
                }
            }
            .ignoresSafeArea()

            // MARK: 팀 변경, 공유 버튼 편집 모달 위치에 따른 분기 처리
            TeamChangeAndShareButton(isSharing: $mainObservable.isSharing,
                                     mainObservable: $mainObservable,
                                     isEditing: mainObservable.currentPresentationDetent == .height(CGFloat.editHeight),
                                     team: observable.team!,
                                     lineup: observable.lineup[mainObservable.currentIndex],
                                     theme: observable.lineup[mainObservable.currentIndex].theme)

            // MARK: 팀 정보
            TeamInfo(mainObservable: $mainObservable,
                     observable: observable)

            // MARK: 기본 화면에서 캐러셀 버튼 출력
            if mainObservable.currentPresentationDetent == .height(CGFloat.defaultHeight) {
                FieldCarouselButton(mainObservable: $mainObservable,
                                    theme: observable.lineup[mainObservable.currentIndex].theme)
            }
        }
        .animation(.linear, value: mainObservable.isShowTeamSheet)
        .background(
            observable.lineup[mainObservable.currentIndex].theme.background
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .animation(.easeInOut, value: mainObservable.currentIndex)
        )
        .sheet(isPresented: $mainObservable.isShowEditSheet, onDismiss: {
            mainObservable.isShowTeamSheet.toggle()
        }, content: {
            if mainObservable.currentPresentationDetent == .height(CGFloat.defaultHeight) {
                ModalDefaultView(mainObservable: $mainObservable, teamObservable: observable)
                    .presentationDragIndicator(.hidden)
                    .presentationDetents(mainObservable.presentationDetents,
                                         selection: $mainObservable.currentPresentationDetent)
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
                    .presentationBackground(.clear)
            } else {
                ModalSegmentedView(editType: $editType,
                                   team: observable.team!,
                                   lineup: observable.lineup[mainObservable.currentIndex],
                                   currentIndex: mainObservable.currentIndex)
                .presentationDragIndicator(.visible)
                .presentationDetents(mainObservable.presentationDetents,
                                     selection: $mainObservable.currentPresentationDetent)
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
                .presentationBackground(.regularMaterial)
            }
        })
        .onChange(of: mainObservable.isShowTeamSheet) { old, _ in
            if old {
                observable.fetchTeam()
            }
        }
        .onChange(of: mainObservable.currentPresentationDetent, { oldValue, newValue in
            if newValue == .height(.defaultHeight) {
                observable.lineup.map { $0.selectionPlayerIndex = nil }
            }
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    mainObservable.isLoading.toggle()
                    mainObservable.isShowEditSheet.toggle()
                }
            }
        }
    }
}

// MARK: Default 모달
struct ModalDefaultView: View {

    @Binding var mainObservable: MainObservable
    var teamObservable: TeamObservable

    var body: some View {
        VStack {
            Image(asset: CommonAsset.upperArrow)
                .foregroundStyle(teamObservable.lineup[mainObservable.currentIndex].theme.textColor)
                .padding(.top, 24)
            Text(String(localized: "Push To Edit"))
                .font(.Pretendard.regular14.font)
                .foregroundStyle(teamObservable.lineup[mainObservable.currentIndex].theme.textColor)
                .padding(.top, 10)
        }
    }
}

// MARK: 필드 캐러셀
struct FieldCarousel: View {
    @Binding var mainObservable: MainObservable
    var lineup: [Lineup]
    var team: Team
    @Binding var editType: EditType

    var body: some View {
        VStack {
            Carousel(pageCount: 3,
                     visibleEdgeSpace: -120,
                     spacing: -30,
                     mainObservable: mainObservable) { index in
                FieldView(observable: FieldObservable(team: team,
                                                      lineup: lineup[index]),
                          isShowEditSheet: mainObservable.currentPresentationDetent == .height(CGFloat.editHeight),
                          editType: $editType,
                          currentPresentationDetent: $mainObservable.currentPresentationDetent)
            }
                     .frame(height: UIScreen.main.bounds.size.height * 0.4)
                     .animation(.spring, value: mainObservable.currentPresentationDetent)
        }
        .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
    }
}

// MARK: 필드 캐러셀 버튼
struct FieldCarouselButton: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    var body: some View {
        HStack {
            // 좌우 carousel 버튼
            buttonView(isLeft: true)
            Spacer()
            buttonView(isLeft: false)
        }
        .padding(.horizontal)
        .padding(.bottom, 100)
        .blur(radius: (mainObservable.isSharing ||  mainObservable.isShowTeamSheet) ? 10 : 0)
    }

    private func buttonView(isLeft: Bool) -> some View {
        Button(action: {
            if isLeft {
                mainObservable.currentIndex = max(mainObservable.currentIndex - 1, 0)
            } else {
                mainObservable.currentIndex = min( mainObservable.currentIndex + 1, 2)
            }
        }, label: {
            Image(systemName: isLeft ? "chevron.left" : "chevron.right")
                .foregroundStyle(theme.textColor)
                .font(.system(size: 20))
                .opacity(isLeft ?
                         (mainObservable.currentIndex == 0 ? 0.3 : 1) : (mainObservable.currentIndex == 2 ? 0.3 : 1))
        })
        .padding()
        .contentShape(Rectangle())
    }
}

// MARK: 팀 변경 버튼 & 공유 버튼
struct TeamChangeAndShareButton: View {

    @State private var snapshotImage: UIImage?
    @Binding var isSharing: Bool
    @Binding var mainObservable: MainObservable

    var isEditing: Bool
    var team: Team
    var lineup: Lineup
    var theme: Theme

    var body: some View {
        VStack {
            HStack {
                if !isEditing {
                    Button {
                        mainObservable.isShowEditSheet.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "flag.2.crossed")
                                .font(.system(size: 20))
                                .foregroundColor(mainObservable.isShowTeamSheet ? Color.black : theme.textColor)
                            Text(String(localized: "Team"))
                                .font(.Pretendard.subhead.font)
                                .foregroundColor(mainObservable.isShowTeamSheet ? Color.black : theme.textColor)
                        }
                        .padding(5)
                        .background(mainObservable.isShowTeamSheet ? Color.white : Color.clear)
                        .clipShape(Circle())
                    }
                    .padding(20)
                    .animation(.easeInOut, value: mainObservable.isShowTeamSheet)
                    Spacer()
                        .sheet(isPresented: $mainObservable.isShowTeamSheet,
                               onDismiss: {
                            mainObservable.isShowEditSheet.toggle()
                        }, content: {
                            TeamSelectView(observable: TeamSelectObservable(modelContext: teamContainer.mainContext))
                                .modelContainer(teamContainer)
                                .background(.clear)
                        })
                } else {
                    Spacer()
                    Button {
                        isSharing.toggle()
                        captureAndShareSnapshot()
                    } label: {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20))
                                .foregroundStyle(lineup.theme.textColor)
                            Text(String(localized: "Share"))
                                .font(.Pretendard.subhead.font)
                                .foregroundStyle(lineup.theme.textColor)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 10)
                    .blur(radius: ( isSharing ) ? 10 : 0)
                }
            }
            Spacer()
                .animation(.easeIn, value: isEditing)
        }
    }

    private func captureAndShareSnapshot() {
        snapshotImage = ShareImage(
            team: team,
            isSharing: isSharing,
            lineup: lineup).snapshot()
        if let image = snapshotImage {
            let metaData = ImageMetadataProvider(image: image, team: team, lineup: lineup)
            showShareSheet(with: [metaData], onDismiss: {
                isSharing.toggle()
            })
        }
    }

}

// MARK: TeamInfo
struct TeamInfo: View {
    @Binding var mainObservable: MainObservable
    var observable: TeamObservable
    // 1.1.0
    let deviceHeight = UIScreen.main.bounds.height

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if mainObservable.currentPresentationDetent == .height(CGFloat.defaultHeight) {
                    // MARK: 페이지 인디케이터
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 6, height: 6)
                            .opacity(mainObservable.currentIndex == index ? 1: 0.3)
                            .animation(.easeInOut(duration: 0.3), value: mainObservable.currentIndex)
                    }
                    .padding(.top, 38)
                }
            }
            HStack {
                Text("\(observable.team!.teamName)")
                    .font(mainObservable.currentPresentationDetent == .height(CGFloat.editHeight)
                          ? .Pretendard.headerLarge.font : .Pretendard.headerNormal.font)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(observable.lineup[mainObservable.currentIndex].theme.textColor)
                    .padding(.top,
                             mainObservable.currentPresentationDetent == .height(CGFloat.editHeight) ? 26 : 40)
                if mainObservable.currentPresentationDetent == .height(CGFloat.editHeight) {
                    Spacer()
                }
            }
            HStack {
                Text(observable.lineup[mainObservable.currentIndex].lineupName)
                    .font(.Pretendard.subhead.font)
                    .foregroundStyle(observable.lineup[mainObservable.currentIndex].theme.textColor)
                if mainObservable.currentPresentationDetent == .height(CGFloat.editHeight) {
                    Spacer()
                }
            }
            .padding(.top,
                     mainObservable.currentPresentationDetent == .height(CGFloat.editHeight) ? 4 : 8)
            Spacer()
        }
        .padding(.leading, mainObservable.currentPresentationDetent == .height(CGFloat.editHeight) ? 24 : 0)
        .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
        .animation(.easeInOut(duration: 0.3), value: mainObservable.currentPresentationDetent)
    }
}
