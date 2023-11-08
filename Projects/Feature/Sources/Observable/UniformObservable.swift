//
//  UniformObservable.swift
//  Feature
//
//  Created by 한지석 on 11/7/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftUI

import Core

@Observable
final class UniformObservable {
    var lineup = Lineup(id: UUID(),
                        uniform: .basic,
                        headcount: .eleven,
                        players: MockData.player,
                        primaryColor: .black)
}

struct MockData {
    static let player: [Player] = [
        Player(name: "호날두",
               number: 1,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: 100),
                                   accumulatedOffset: CGSize(width: 0, height: 100))),
        Player(name: "호날두",
               number: 2,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: -75, height: 50),
                                   accumulatedOffset: CGSize(width: -75, height: 50))),
        Player(name: "호날두",
               number: 3,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 75, height: 50),
                                   accumulatedOffset: CGSize(width: 75, height: 50))),
        Player(name: "호날두",
               number: 4,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 140, height: 30),
                                   accumulatedOffset: CGSize(width: 140, height: 30))),
        Player(name: "호날두",
               number: 5,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: -140, height: 30),
                                   accumulatedOffset: CGSize(width: -140, height: 30))),
        Player(name: "호날두",
               number: 6,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: 20),
                                   accumulatedOffset: CGSize(width: 0, height: 20))),
        Player(name: "호날두",
               number: 7,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 70, height: -20),
                                   accumulatedOffset: CGSize(width: 70, height: -20))),
        Player(name: "호날두",
               number: 8,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: -70, height: -20),
                                   accumulatedOffset: CGSize(width: -70, height: -20))),
        Player(name: "호날두",
               number: 9,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: -80),
                                   accumulatedOffset: CGSize(width: 0, height: -80))),
        Player(name: "호날두",
               number: 10,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 130, height: -80),
                                   accumulatedOffset: CGSize(width: 130, height: -80))),
        Player(name: "호날두",
               number: 11,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: -130, height: -80),
                                   accumulatedOffset: CGSize(width: -130, height: -80)))
    ]
}
