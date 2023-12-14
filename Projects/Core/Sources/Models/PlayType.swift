//
//  Formation.swift
//  Core
//
//  Created by 한지석 on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum PlayType: Int, Codable, CaseIterable {
    case five = 5
    case six = 6
    case eleven = 11

    public var typeOfFormation: [Formation] {
        switch self {
        case .five:
            [
                Formation.futsal22,
                Formation.futsal121
            ]
        case .six:
            [
                Formation.futsal32,
                Formation.futsal131,
                Formation.futsal212
            ]
        case .eleven:
            [
                Formation.football343,
                Formation.football442,
                Formation.football433,
                Formation.football4231,
                Formation.football4141,
                Formation.football523
            ]
        }
    }
}
