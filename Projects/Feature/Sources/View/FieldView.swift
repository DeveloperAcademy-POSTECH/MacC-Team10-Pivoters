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
    @State var observable: FieldObservable

    var body: some View {
        ZStack {
            Image(asset: CommonAsset.field)
                .coordinateSpace(name: "\(observable.formation)")
                .onTapGesture {
                    observable.changeFormation(.form523)
                }
            ForEach($observable.lineup.players) { player in
                  if player.isGoalkeeper.wrappedValue {
                      PlayerView(player: player.wrappedValue)
                          .offset(player.offset.draggedOffset.wrappedValue)
                  } else {
                      PlayerView(player: player.wrappedValue)
                          .offset(player.offset.draggedOffset.wrappedValue)
                          .gesture(
                              DragGesture(coordinateSpace: .named("field"))
                                  .onChanged { gesture in
                                      let draggedOffset =
 
                                      player.offset.accumulatedOffset.wrappedValue
                                      + gesture.translation
                                      player.offset.draggedOffset.wrappedValue = draggedOffset

                                      print("\(player.offset.draggedOffset)")
                                  }
                                  .onEnded { gesture in
                                      let accumulatedOffset =
                                      player.offset.accumulatedOffset.wrappedValue
                                      + gesture.translation
                                      player.offset.accumulatedOffset.wrappedValue = accumulatedOffset
                                  }
                          )
                }
            }
        }
    }
}
