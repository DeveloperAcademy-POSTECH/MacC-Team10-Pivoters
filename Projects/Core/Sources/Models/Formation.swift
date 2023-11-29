//
//  Formation.swift
//  Core
//
//  Created by 한지석 on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum Formation: Int, Codable, CaseIterable {
    case five = 5
    case six = 6
    case eleven = 11

    public var typeOfFormation: [TypeOfFormation] {
        switch self {
        case .five:
            [TypeOfFormation.futsal22,
             TypeOfFormation.futsal121]
        case .six:
            [TypeOfFormation.futsal32,
             TypeOfFormation.futsal131,
             TypeOfFormation.futsal212]
        case .eleven:
            [TypeOfFormation.football343,
             TypeOfFormation.football442,
             TypeOfFormation.football433,
             TypeOfFormation.football4231,
             TypeOfFormation.football4141,
             TypeOfFormation.football523]
        }
    }
}
