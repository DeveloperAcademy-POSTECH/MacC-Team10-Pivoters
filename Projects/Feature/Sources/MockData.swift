//
//  MockData.swift
//  Feature
//
//  Created by 한지석 on 11/16/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

struct MockData {
    static let teams: [Team] = [
        Team(id: UUID(), teamName: "첼시 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "토트넘 훗스퍼", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "갈라타사라이 현대 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "첼시 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "토트넘 훗스퍼", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "갈라타사라이 현대 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "첼시 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "토트넘 훗스퍼", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup),
        Team(id: UUID(), teamName: "갈라타사라이 현대 FC", subTitle: "2023 아시안 챔피언스 리그 결승전 선발 멤버", lineup: MockData.initLineup)
    ]

    static let initLineup: [Lineup] = [
        Lineup(id: UUID(),
               uniform: .plain,
               formation: .eleven,
               selectedTypeOfFormation: .football433,
               players: MockData.player,
               primaryColor: UniformColor(red: 0, green: 0, blue: 0),
               secondaryColor: UniformColor(red: 255, green: 255, blue: 255)),
        Lineup(id: UUID(),
               uniform: .plain,
               formation: .eleven,
               selectedTypeOfFormation: .football433,
               players: MockData.player,
               primaryColor: UniformColor(red: 0, green: 0, blue: 0),
               secondaryColor: UniformColor(red: 255, green: 255, blue: 255)),
        Lineup(id: UUID(),
               uniform: .plain,
               formation: .eleven,
               selectedTypeOfFormation: .football433,
               players: MockData.player,
               primaryColor: UniformColor(red: 0, green: 0, blue: 0),
               secondaryColor: UniformColor(red: 255, green: 255, blue: 255))
    ]

    static let player: [Player] = [
        Player(id: UUID(),
               name: " ",
               number: 1,
               isGoalkeeper: true,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: 100),
                                   accumulatedOffset: CGSize(width: 0, height: 100))),
        Player(id: UUID(),
               name: " ",
               number: 2,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: -75, height: 50),
                                   accumulatedOffset: CGSize(width: -75, height: 50))),
        Player(id: UUID(),
               name: " ",
               number: 3,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 75, height: 50),
                                   accumulatedOffset: CGSize(width: 75, height: 50))),
        Player(id: UUID(),
               name: " ",
               number: 4,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 140, height: 30),
                                   accumulatedOffset: CGSize(width: 140, height: 30))),
        Player(id: UUID(),
               name: " ",
               number: 5,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: -140, height: 30),
                                   accumulatedOffset: CGSize(width: -140, height: 30))),
        Player(id: UUID(),
               name: " ",
               number: 6,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: 20),
                                   accumulatedOffset: CGSize(width: 0, height: 20))),
        Player(id: UUID(),
               name: " ",
               number: 7,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 70, height: -20),
                                   accumulatedOffset: CGSize(width: 70, height: -20))),
        Player(id: UUID(),
               name: " ",
               number: 8,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: -70, height: -20),
                                   accumulatedOffset: CGSize(width: -70, height: -20))),
        Player(id: UUID(),
               name: " ",
               number: 9,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 0, height: -80),
                                   accumulatedOffset: CGSize(width: 0, height: -80))),
        Player(id: UUID(),
               name: " ",
               number: 10,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: 130, height: -80),
                                   accumulatedOffset: CGSize(width: 130, height: -80))),
        Player(id: UUID(),
               name: " ",
               number: 11,
               isGoalkeeper: false,
               offset: OffsetValue(draggedOffset: CGSize(width: -130, height: -80),
                                   accumulatedOffset: CGSize(width: -130, height: -80)))
    ]
}
