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

    @MainActor
    public init(modelContext: ModelContext) {
        let observable = TeamObservable(modelContext: modelContext)
        _observable = State(initialValue: observable)
    }

    public var body: some View {
        ZStack {
            // LaunchScreen 뷰
            LaunchScreenView(isLoading: $mainObservable.isLoading).transition(.opacity).zIndex(1)
            // 공유 버튼을 클릭시 최상단 계층에서 오버레이
            ShareImage(isSharing: $mainObservable.isSharing).zIndex(1)
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            if !mainObservable.isShowEditSheet {
                                TeamChangeButton(mainObservable: $mainObservable, theme: observable.lineup[mainObservable.currentIndex].theme)
                                Spacer()
                            } else {
                                Spacer()
                                ShareButton(mainObservable: $mainObservable, theme: observable.lineup[mainObservable.currentIndex].theme)
                            }
                        }
                        Spacer()
                    }
                    TeamInfo(mainObservable: $mainObservable, observable: observable)
                }
                if !mainObservable.isShowEditSheet {
                    FieldCarouselButton(mainObservable: $mainObservable, theme: observable.lineup[mainObservable.currentIndex].theme)
                }
                Spacer()
                FieldCarousel(mainObservable: $mainObservable, lineup: observable.lineup)
                if mainObservable.isShowEditSheet {
                    EditSheetModalSection(mainObservable: $mainObservable, lineup: observable.lineup[mainObservable.currentIndex])
                } else {
                    EditSheetIndicator(mainObservable: $mainObservable, theme: observable.lineup[mainObservable.currentIndex].theme)
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
            .onChange(of: mainObservable.isShowTeamSheet) { old, _ in
                if old {
                    observable.fetchTeam()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation {
                        mainObservable.isLoading.toggle()
                        mainObservable.isShowEditSheet = mainObservable.isLoading
                    }
                })
            }
        }
    }
}

// 편집 시트 모달 섹션
struct EditSheetModalSection: View {
    @Binding var mainObservable: MainObservable

    var lineup: Lineup

    var body: some View {
        VStack {
            ModalSegmentedView(lineup: lineup)
                .animation(.easeInOut, value: mainObservable.isShowEditSheet)
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
        }.frame(height: UIScreen.main.bounds.height * 3 / 7)
    }
}

// 필드 캐러셀
struct FieldCarousel: View {

    @Binding var mainObservable: MainObservable
    var lineup: [Lineup]

    var body: some View {
        Carousel(pageCount: 3,
                 visibleEdgeSpace: -120,
                 spacing: -30,
                 currentIndex: $mainObservable.currentIndex) { index in
            VStack {
                FieldView(observable: FieldObservable(lineup: lineup[index]))
            }
        }
                 .offset(y: mainObservable.editSheetIndicatorOffset + 10) // +10: 그림자 값
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
            let maxDragHeight = screenHeight / 2
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
                Spacer()
            }
            .background(Color.gray.opacity(0.001)) // 터치 가능한 영역 설정
            .offset(y: mainObservable.editSheetIndicatorOffset + 20)
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

// 필드 캐러셀 버튼
struct FieldCarouselButton: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    var body: some View {
        VStack {
            Spacer()
            HStack {
                // 좌우 carousel 버튼
                buttonView(isLeft: true)
                Spacer()
                buttonView(isLeft: false)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .blur(radius: ( mainObservable.isSharing ||  mainObservable.isShowTeamSheet) ? 10 : 0)
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
                .opacity(isLeft ? (mainObservable.currentIndex == 0 ? 0.3 : 1) : (mainObservable.currentIndex == 2 ? 0.3 : 1))
        })
        .padding()
        .contentShape(Rectangle())
    }
}

// 팀 변경 버튼
struct TeamChangeButton: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    var body: some View {
        Button(action: {
            mainObservable.isShowTeamSheet.toggle()
        }, label: {
                VStack {
                    Image(systemName: "flag.2.crossed")
                        .font(.system(size: 20))
                        .foregroundColor(mainObservable.isShowTeamSheet ? Color.black : theme.textColor)
                    Text("팀 변경")
                        .font(.Pretendard.subhead.font)
                        .foregroundColor(mainObservable.isShowTeamSheet ? Color.black : theme.textColor)
                }
                .padding(.all, 9)
                .background(mainObservable.isShowTeamSheet ? Color.white : Color.clear)
                .clipShape(Circle())
        })
        .sheet(isPresented: $mainObservable.isShowTeamSheet) {
            TeamSelectView(observable: TeamSelectObservable(modelContext: teamContainer.mainContext))
                .modelContainer(teamContainer)
        }
        .animation(.easeInOut, value: mainObservable.isShowTeamSheet)
        .padding()
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
        Button {
            captureAndShareSnapshot()
        } label: {
            VStack {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .foregroundStyle(theme.textColor)
                Text("공유하기")
                    .font(.Pretendard.subhead.font)
                    .foregroundStyle(theme.textColor)
            }
        }
        .padding(25)
    }
}

// 팀 정보 텍스트 섹션
struct TeamInfo: View {
    @Binding var mainObservable: MainObservable
    var observable: TeamObservable

    var body: some View {
        VStack {
            HStack {
                Text(observable.team!.teamName)
                    .font(mainObservable.isShowEditSheet ? .Pretendard.headerLarge.font: .Pretendard.headerNormal.font)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(observable.lineup[mainObservable.currentIndex].theme.textColor)
                if mainObservable.isShowEditSheet {
                    Spacer()
                }
            }
            HStack {
                Text(observable.lineup[mainObservable.currentIndex].lineupName)
                    .font(.Pretendard.subhead.font)
                    .foregroundStyle(observable.lineup[mainObservable.currentIndex].theme.textColor)
                if mainObservable.isShowEditSheet {
                    Spacer()
                }
            }
        }
//        .padding(.top, mainObservable.isShowEditSheet ? 30 : 90)
        .padding(.leading, mainObservable.isShowEditSheet ? 24 : 0)
        .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
        .animation(.easeInOut(duration: 0.3), value: mainObservable.isShowEditSheet)
    }
}

extension View {

}
