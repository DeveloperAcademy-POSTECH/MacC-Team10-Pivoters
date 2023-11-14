//
//  Carousel.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/10/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

public struct Carousel<Content: View>: View {
    public typealias PageIndex = Int

    let pageCount: Int
    let visibleEdgeSpace: CGFloat
    let spacing: CGFloat
    let content: (PageIndex) -> Content

    @GestureState var dragOffset: CGFloat = 0
    @Binding var currentIndex: Int

    public init(
        pageCount: Int,
        visibleEdgeSpace: CGFloat,
        spacing: CGFloat,
        currentIndex: Binding<Int>,
        @ViewBuilder content: @escaping (PageIndex) -> Content
    ) {
        self.pageCount = pageCount
        self.visibleEdgeSpace = visibleEdgeSpace
        self.spacing = spacing
        self.content = content
        self._currentIndex = currentIndex
    }

    public var body: some View {
        GeometryReader { proxy in
            let baseOffset: CGFloat = spacing + visibleEdgeSpace
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
            let offsetX: CGFloat = baseOffset
            + CGFloat(currentIndex) * -pageWidth
            + CGFloat(currentIndex) * -spacing
            + dragOffset

            HStack(spacing: spacing) {
                ForEach(0..<pageCount, id: \.self) { pageIndex in
                    self.content(pageIndex)
                        .frame(
                            width: pageWidth,
                            height: proxy.size.height
                        )
                }
                .contentShape(Rectangle())
            }
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let sensitivity: CGFloat = 0.5 // carousel 민감도
                        let offsetX = value.translation.width
                        let progress = -offsetX / (pageWidth * sensitivity)
                        let increment = Int(progress.rounded())

                        currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
                    }
            )
            .animation(.spring, value: offsetX)
        }
    }
}
