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
    @Environment(FieldObservable.self) var fieldObservable

    var body: some View {
        ZStack {
            fieldObservable.theme.field
                .offset(CGSize(width: 0, height: 100))
            ForEach(0..<fieldObservable.lineup.formation.rawValue, id: \.hashValue) { index in
                if fieldObservable.lineup.players[index].isGoalkeeper {
                    PlayerView(theme: fieldObservable.theme, player: fieldObservable.lineup.players[index])
                          .offset(fieldObservable.lineup.players[index].offset.draggedOffset)
                          .onTapGesture {
                              fieldObservable.selectionPlayerIndex = index
                          }
                  } else {
                      PlayerView(theme: fieldObservable.theme, player: fieldObservable.lineup.players[index])
                          .offset(fieldObservable.lineup.players[index].offset.draggedOffset)
                          .gesture(
                            DragGesture()
                                  .onChanged { gesture in
                                      let draggedOffset =
                                      fieldObservable.lineup.players[index].offset.accumulatedOffset
                                      + gesture.translation
                                      fieldObservable.lineup.players[index].offset.draggedOffset = draggedOffset
                                      print("\(fieldObservable.lineup.players[index].offset.draggedOffset)")
                                  }
                                  .onEnded { gesture in
                                      let accumulatedOffset =
                                      fieldObservable.lineup.players[index].offset.accumulatedOffset
                                      + gesture.translation
                                      fieldObservable.lineup.players[index].offset.accumulatedOffset = accumulatedOffset
                                  }
                          )
                          .onTapGesture {
                              fieldObservable.selectionPlayerIndex = index
                          }
                }
            }
        }
    }
}
