//
//  Carousel.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

struct Carousel<Content: View>: View {
    public typealias PageIndex = Int

    let pageCount: Int
    let visibleEdgeSpace: CGFloat
    let spacing: CGFloat
    let content: (PageIndex) -> Content

    @GestureState var dragOffset: CGFloat = 0
    var mainObservable: MainObservable

    init(
        pageCount: Int,
        visibleEdgeSpace: CGFloat,
        spacing: CGFloat,
        mainObservable: MainObservable,
        @ViewBuilder content: @escaping (PageIndex) -> Content
    ) {
        self.pageCount = pageCount
        self.visibleEdgeSpace = visibleEdgeSpace
        self.spacing = spacing
        self.content = content
        self.mainObservable = mainObservable
    }

    public var body: some View {
        GeometryReader { proxy in
            let baseOffset: CGFloat = spacing + visibleEdgeSpace
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
            let offsetX: CGFloat = baseOffset
            + CGFloat(mainObservable.currentIndex) * -pageWidth
            + CGFloat(mainObservable.currentIndex) * -spacing
            + dragOffset
            VStack {
                Spacer()
                HStack(spacing: spacing) {
                    ForEach(0..<pageCount, id: \.self) { pageIndex in
                        self.content(pageIndex)
                            .frame(
                                width: pageWidth,
                                height: UIScreen.main.bounds.size.height * 0.4
                            )
                    }
                    .contentShape(Rectangle())
                }
            }
            .frame(height: UIScreen.main.bounds.size.height * 0.4)
            .offset(x: offsetX)
            .gesture(
                // MARK: 1129 변경
                mainObservable.currentPresentationDetent == .height(CGFloat.editHeight)
                ? DragGesture()
                    .updating($dragOffset) { _, _, _ in
                        print("update gesture.")
                    }
                    .onEnded { _ in
                        print("ended gesture.")
                    } :
                    DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let sensitivity: CGFloat = 0.3 // carousel 민감도
                        let offsetX = value.translation.width
                        let progress = -offsetX / (pageWidth * sensitivity)
                        let increment = Int(progress.rounded())

                        mainObservable.currentIndex =
                        max(min(mainObservable.currentIndex + increment, pageCount - 1), 0)
                    }
            )
            .animation(.spring, value: offsetX)
        }
    }
}
