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
            Image(asset: CommonAsset.field)
                .coordinateSpace(name: "\(fieldObservable.formation)")
                .onTapGesture {
                    fieldObservable.changeFormation(.form523)
                }
            ForEach(fieldObservable.lineup.players) { player in
                  if player.isGoalkeeper {
                      PlayerView(player: player)
                          .offset(player.offset.draggedOffset)
                  } else {
                      PlayerView(player: player)
                          .offset(player.offset.draggedOffset)
                          .gesture(
                            DragGesture(coordinateSpace: .named("\(fieldObservable.viewTrigger)"))
                                  .onChanged { gesture in
                                      let draggedOffset =
                                      player.offset.accumulatedOffset
                                      + gesture.translation
                                      player.offset.draggedOffset = draggedOffset
                                      print("\(player.offset.draggedOffset)")
                                      fieldObservable.viewTrigger = Int.random(in: 0..<100)
                                  }
                                  .onEnded { gesture in
                                      let accumulatedOffset =
                                      player.offset.accumulatedOffset
                                      + gesture.translation
                                      player.offset.accumulatedOffset = accumulatedOffset
                                  }
                          )
                }
            }
        }
    }
}
