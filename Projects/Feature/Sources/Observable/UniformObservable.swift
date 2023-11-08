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
public final class UniformObservable {

    var lineup = Lineup(id: UUID(),
                        uniformType: .basic,
                        headcount: .eleven,
                        players: MockData.player,
                        primaryColor: UniformColor(red: 0.4,
                                                   green: 0.4,
                                                   blue: 0.4),
                        secondaryColor: UniformColor(red: 0.2,
                                                     green: 0.2,
                                                     blue: 0.2))

    public init () { }

    func updateUniformColor(colors: [String], colorSequence: ColorSequence) {
        let colorsTypeDouble = stringToDouble(colors: colors)
        switch colorSequence {
        case .primaryColor:
            self.lineup.primaryColor.red = colorsTypeDouble[0]
            self.lineup.primaryColor.green = colorsTypeDouble[1]
            self.lineup.primaryColor.blue = colorsTypeDouble[2]
        case .secondaryColor:
            self.lineup.secondaryColor.red = colorsTypeDouble[0]
            self.lineup.secondaryColor.green = colorsTypeDouble[1]
            self.lineup.secondaryColor.blue = colorsTypeDouble[2]
        }
    }

    func stringToDouble(colors: [String]) -> [Double] {
        var colorsTypeDouble: [Double] = []
        for index in 1..<5 {
            colorsTypeDouble.append(Double(colors[index]) ?? 0.1)
        }
        return colorsTypeDouble
    }
}

enum ColorSequence {
    case primaryColor
    case secondaryColor
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
