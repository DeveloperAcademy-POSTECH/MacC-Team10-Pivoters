//
//  FieldView.swift
//  Feature
//
//  Created by 박승찬 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import SwiftUI

import Common
import Core

struct FieldView: View {
    var observable: FieldObservable
    var isShowEditSheet: Bool
    let noneGesture = DragGesture()
        .onChanged { _ in
            print("onChange")
        }
        .onEnded { _ in
            print("noneGesture")
        }

    var body: some View {
        ZStack {
            observable.lineup.theme.field
                .offset(CGSize(width: 0, height: 100))
            ForEach(0..<observable.lineup.formation.rawValue, id: \.hashValue) { index in
                if observable.players[index].isGoalkeeper {
                    PlayerView(theme: observable.lineup.theme,
                               player: observable.players[index],
                               lineup: observable.lineup)
                    .offset(CGSize(width: observable.players[index].offset.draggedOffsetWidth,
                                   height: observable.players[index].offset.draggedOffsetHeight))
                    .onTapGesture {
                        observable.lineup.selectionPlayerIndex = index
                    }
                } else {
                    PlayerView(theme: observable.lineup.theme,
                               player: observable.players[index],
                               lineup: observable.lineup)
                    .offset(CGSize(width: observable.players[index].offset.draggedOffsetWidth,
                                   height: observable.players[index].offset.draggedOffsetHeight))
                    .gesture(
                        isShowEditSheet ?
                        DragGesture()
                            .onChanged { gesture in
                                let draggedOffsetWidth =
                                gesture.translation.width +
                                observable.players[index].offset.accumulatedOffsetWidth
                                let draggedOffsetHeight =
                                gesture.translation.height +
                                observable.players[index].offset.accumulatedOffsetHeight
                                observable.players[index].offset.draggedOffsetWidth =
                                draggedOffsetWidth > 0 ? min(draggedOffsetWidth, 180): max(draggedOffsetWidth, -180)
                                observable.players[index].offset.draggedOffsetHeight =
                                draggedOffsetHeight > 0 ? min(draggedOffsetHeight, 120): max(draggedOffsetHeight, -110)
                            }
                            .onEnded { gesture in
                                let accumulatedOffsetWidth =
                                gesture.translation.width +
                                observable.players[index].offset.accumulatedOffsetWidth
                                let accumulatedOffsetHeight =
                                gesture.translation.height +
                                observable.players[index].offset.accumulatedOffsetHeight
                                observable.players[index].offset.accumulatedOffsetWidth =
                                accumulatedOffsetWidth > 0 ?
                                min(accumulatedOffsetWidth, 180): max(accumulatedOffsetWidth, -180)
                                observable.players[index].offset.accumulatedOffsetHeight =
                                accumulatedOffsetHeight > 0 ?
                                min(accumulatedOffsetHeight, 120): max(accumulatedOffsetHeight, -110)
                            }:
                            noneGesture

                    )
                    .onTapGesture {
                        observable.lineup.selectionPlayerIndex = index
                    }
                }
            }
        }
    }
}
