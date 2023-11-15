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

    var body: some View {
        ZStack {
            observable.lineup.theme.field
                .offset(CGSize(width: 0, height: 100))
            ForEach(0..<observable.lineup.formation.rawValue, id: \.hashValue) { index in
                if observable.lineup.players[index].isGoalkeeper {
                    PlayerView(theme: observable.lineup.theme, player: observable.lineup.players[index])
                          .offset(observable.lineup.players[index].offset.draggedOffset)
                          .onTapGesture {
                              observable.lineup.selectionPlayerIndex = index
                          }
                  } else {
                      PlayerView(theme: observable.lineup.theme, player: observable.lineup.players[index])
                          .offset(observable.lineup.players[index].offset.draggedOffset)
                          .gesture(
                            DragGesture()
                                  .onChanged { gesture in
                                      let draggedOffset =
                                      observable.lineup.players[index].offset.accumulatedOffset
                                      + gesture.translation
                                      observable.lineup.players[index].offset.draggedOffset = draggedOffset
                                      print("\(observable.lineup.players[index].offset.draggedOffset)")
                                  }
                                  .onEnded { gesture in
                                      let accumulatedOffset =
                                      observable.lineup.players[index].offset.accumulatedOffset
                                      + gesture.translation
                                      observable.lineup.players[index].offset.accumulatedOffset = accumulatedOffset
                                  }
                          )
                          .onTapGesture {
                              observable.lineup.selectionPlayerIndex = index
                          }
                }
            }
        }
    }
}
