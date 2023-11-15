//
//  TeamObservable.swift
//  Feature
//
//  Created by 박승찬 on 11/16/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

import Core

@Observable
class TeamObservable {
    var team: Team = Team(id: UUID(),
                          teamName: "어찌구fc",
                          subTitle: "저찌구",
                          lineup: [Lineup(id: UUID(),
                                          uniform: .plain,
                                          formation: .eleven,
                                          selectedTypeOfFormation: .football433,
                                          players: MockData.player,
                                          primaryColor: UniformColor(red: 0.4,
                                                                     green: 0.4,
                                                                     blue: 0.4),
                                          secondaryColor: UniformColor(red: 0.2,
                                                                       green: 0.2,
                                                                       blue: 0.2),
                                          theme: .blackBlue),
                                   Lineup(id: UUID(),
                                          uniform: .plain,
                                          formation: .eleven,
                                          selectedTypeOfFormation: .football433,
                                          players: MockData.player,
                                          primaryColor: UniformColor(red: 0.4,
                                                                     green: 0.4,
                                                                     blue: 0.4),
                                          secondaryColor: UniformColor(red: 0.2,
                                                                       green: 0.2,
                                                                       blue: 0.2),
                                          theme: .blackBlue),
                                   Lineup(id: UUID(),
                                          uniform: .plain,
                                          formation: .eleven,
                                          selectedTypeOfFormation: .football433,
                                          players: MockData.player,
                                          primaryColor: UniformColor(red: 0.4,
                                                                     green: 0.4,
                                                                     blue: 0.4),
                                          secondaryColor: UniformColor(red: 0.2,
                                                                       green: 0.2,
                                                                       blue: 0.2),
                                          theme: .blackBlue)
                          ])
}
