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
            ShareView(mainObservable: mainObservable,
                      team: observable.team,
                      lineup: observable.lineup[mainObservable.currentIndex]).zIndex(1)
            VStack {
                HStack {
                    if !mainObservable.isShowEditSheet {
                        TeamChangeButton(mainObservable: $mainObservable,
                                         theme: observable.lineup[mainObservable.currentIndex].theme)
                        Spacer()
                    } else {
                        Spacer()
                        ShareButton(mainObservable: mainObservable,
                                    team: observable.team!,
                                    lineup: observable.lineup[mainObservable.currentIndex])
                    }
                }
                TeamInfo(mainObservable: $mainObservable,
                         observable: observable)
                Spacer()
                ZStack {
                    FieldCarousel(mainObservable: mainObservable, lineup: observable.lineup)
                    if !mainObservable.isShowEditSheet {
                        FieldCarouselButton(mainObservable: $mainObservable,
                                            theme: observable.lineup[mainObservable.currentIndex].theme)
                    }
                }
                if mainObservable.isShowEditSheet {
                    EditSheetModalSection(mainObservable: $mainObservable,
                                          team: observable.team!,
                                          lineup: observable.lineup[mainObservable.currentIndex])
                } else {
                    EditSheetIndicator(mainObservable: $mainObservable,
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

    var team: Team
    var lineup: Lineup

    var body: some View {

        ModalSegmentedView(team: team, lineup: lineup)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 || mainObservable.editSheetOffset > 0 {
                            mainObservable.editSheetOffset += value.translation.height
                        }
                    }
                    .onEnded { _ in
                        if mainObservable.editSheetOffset > 50 {
                            mainObservable.isShowEditSheet = false
                        }
                        mainObservable.editSheetOffset = 0
                    }
            )

        .frame(height: UIScreen.main.bounds.height * 3 / 7)
        .offset(y: mainObservable.editSheetOffset)
        .animation(.easeInOut, value: mainObservable.isShowEditSheet)
    }
}

// 필드 캐러셀
struct FieldCarousel: View {
    var mainObservable: MainObservable
    var lineup: [Lineup]

    var body: some View {
        Carousel(pageCount: 3,
                 visibleEdgeSpace: -120,
                 spacing: -30,
                 mainObservable: mainObservable) { index in
            FieldView(observable: FieldObservable(lineup: lineup[index]),
                      isShowEditSheet: mainObservable.isShowEditSheet)
                .offset(y: mainObservable.isShowEditSheet ?
                        mainObservable.editSheetOffset: mainObservable.editSheetIndicatorOffset
                        + UIScreen.main.bounds.height / 7)
        }
                 .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
                 .animation(.easeInOut(duration: 0.4), value: mainObservable.isShowEditSheet)
    }
}

// "밀어올려서 편집하기" 전환 영역
struct EditSheetIndicator: View {
    @Binding var mainObservable: MainObservable
    var theme: Theme

    let maxDragHeight = UIScreen.main.bounds.height / 3

    var body: some View {
        VStack {
            Image(systemName: "arrowshape.up")
                .foregroundStyle(theme.textColor)
                .padding(.bottom, 10)
                .padding(.top, 30)
            Text("밀어올려서 편집하기")
                .font(.Pretendard.regular14.font)
                .foregroundStyle(theme.textColor)
                .padding(.bottom, 15)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.001)) // 터치 가능한 영역 설정
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
        .sheet(isPresented: $mainObservable.isShowEditSheet) {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        }
    }
}

// 필드 캐러셀 버튼
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
                .opacity(isLeft ?
                         (mainObservable.currentIndex == 0 ? 0.3 : 1) : (mainObservable.currentIndex == 2 ? 0.3 : 1))
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
    var mainObservable: MainObservable
    var team: Team
    @State private var snapshotImage: UIImage?
    var lineup: Lineup

    private func captureAndShareSnapshot() {
        snapshotImage = ShareImage(mainObservable: mainObservable,
                                   team: team,
                                   isSharing: mainObservable.isSharing,
                                   lineup: lineup).snapshot()
        if let image = snapshotImage {
            let metaData = ImageMetadataProvider(image: image, team: team, lineup: lineup)
            showShareSheet(with: [metaData], onDismiss: {
                mainObservable.isSharing = false
            })
        }
    }

    var body: some View {
        Button {
            mainObservable.isSharing = true
            captureAndShareSnapshot()
        } label: {
            VStack {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .foregroundStyle(lineup.theme.textColor)
                Text("공유하기")
                    .font(.Pretendard.subhead.font)
                    .foregroundStyle(lineup.theme.textColor)
            }
        }
        .padding(25)
        .blur(radius: ( mainObservable.isSharing ||  mainObservable.isShowTeamSheet) ? 10 : 0)
    }
}

// 팀 정보 텍스트 섹션
struct TeamInfo: View {
    @Binding var mainObservable: MainObservable
    var observable: TeamObservable

    var body: some View {
        VStack {
            HStack {
                if !mainObservable.isShowEditSheet {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 6, height: 6)
                            .opacity(mainObservable.currentIndex == index ? 1: 0.3)
                            .animation(.easeInOut(duration: 0.3), value: mainObservable.currentIndex)
                    }.offset(y: -50)
                }
            }
            HStack {
                Text("\(observable.team!.teamName)")
                    .font(mainObservable.isShowEditSheet ? .Pretendard.headerLarge.font: .Pretendard.headerNormal.font)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(observable.lineup[mainObservable.currentIndex].theme.textColor)
                    .padding(.bottom, 8)
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
        .padding(.top, mainObservable.isShowEditSheet ? -50 : 0)
        .padding(.leading, mainObservable.isShowEditSheet ? 24 : 0)
        .blur(radius: (mainObservable.isSharing || mainObservable.isShowTeamSheet) ? 10 : 0)
        .animation(.easeInOut(duration: 0.3), value: mainObservable.isShowEditSheet)
    }
}
