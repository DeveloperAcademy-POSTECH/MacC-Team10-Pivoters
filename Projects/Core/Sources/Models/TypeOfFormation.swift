//
//  FormationType.swift
//  Core
//
//  Created by 박승찬 on 11/8/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum TypeOfFormation: String, Codable {
    case football343 = "3-4-3"
    case football442 = "4-4-2"
    case football433 = "4-3-3"
    case football4231 = "4-2-3-1"
    case football4141 = "4-1-4-1"
    case football523 = "5-2-3"

    case futsal121 = "1-2-1"
    case futsal22 = "2-2"

    case futsal32 = "3-2"
    case futsal212 = "2-1-2"
    case futsal131 = "1-3-1"

    public func returnPosition() -> [CGSize] {
        switch self {
        case .football343:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: 0, height: 45), CGSize(width: -80, height: 45),
                CGSize(width: 80, height: 45), CGSize(width: -40, height: -15),
                CGSize(width: 40, height: -15), CGSize(width: -130, height: -15),
                CGSize(width: 130, height: -15), CGSize(width: 0, height: -80),
                CGSize(width: -90, height: -80), CGSize(width: 90, height: -80)
            ]
        case .football442:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: -50, height: 50), CGSize(width: 50, height: 50),
                CGSize(width: -140, height: 40), CGSize(width: 140, height: 40),
                CGSize(width: -50, height: -20), CGSize(width: 50, height: -20),
                CGSize(width: -140, height: -25), CGSize(width: 140, height: -25),
                CGSize(width: -50, height: -80), CGSize(width: 50, height: -80)
            ]
        case .football433:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: -50, height: 50), CGSize(width: 50, height: 50),
                CGSize(width: -140, height: 30), CGSize(width: 140, height: 30),
                CGSize(width: 0, height: 10), CGSize(width: -70, height: -20),
                CGSize(width: 70, height: -20), CGSize(width: 0, height: -80),
                CGSize(width: -130, height: -80), CGSize(width: 130, height: -80)
            ]
        case .football4231:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: -50, height: 60), CGSize(width: 50, height: 60),
                CGSize(width: -140, height: 40), CGSize(width: 140, height: 40),
                CGSize(width: -50, height: 0), CGSize(width: 50, height: 0),
                CGSize(width: 0, height: -45), CGSize(width: -100, height: -45),
                CGSize(width: 100, height: -45), CGSize(width: 0, height: -100)
            ]
        case .football4141:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: -50, height: 50), CGSize(width: 50, height: 50),
                CGSize(width: -130, height: 30), CGSize(width: 130, height: 30),
                CGSize(width: 0, height: 10), CGSize(width: -50, height: -20),
                CGSize(width: 50, height: -20), CGSize(width: -130, height: -30),
                CGSize(width: 130, height: -30), CGSize(width: 0, height: -80)
            ]
        case .football523:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: 0, height: 50), CGSize(width: -75, height: 50),
                CGSize(width: 75, height: 50), CGSize(width: -140, height: 5),
                CGSize(width: 140, height: 5), CGSize(width: 50, height: -20),
                CGSize(width: -50, height: -20), CGSize(width: 0, height: -80),
                CGSize(width: 130, height: -80), CGSize(width: -130, height: -80)
            ]
        case .futsal121:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: 0, height: 40), CGSize(width: -130, height: -15),
                CGSize(width: 130, height: -15), CGSize(width: 0, height: -80)
            ]
        case .futsal22:
            return [
                CGSize(width: 0, height: 100),
                CGSize(width: -130, height: 40), CGSize(width: 130, height: 40),
                CGSize(width: -130, height: -80), CGSize(width: 130, height: -80)
            ]
        case .futsal32:
            return [
                CGSize(width: 0, height: 100), CGSize(width: 0, height: 40),
                CGSize(width: -130, height: 40), CGSize(width: 130, height: 40),
                CGSize(width: -80, height: -80), CGSize(width: 80, height: -80)
            ]
        case .futsal212:
            return [
                CGSize(width: 0, height: 100), CGSize(width: -130, height: 40),
                CGSize(width: 130, height: 40), CGSize(width: 0, height: -15),
                CGSize(width: -130, height: -80), CGSize(width: 130, height: -80)
            ]
        case .futsal131:
            return [
                CGSize(width: 0, height: 100), CGSize(width: 0, height: 40),
                CGSize(width: 0, height: -15), CGSize(width: -130, height: -15),
                CGSize(width: 130, height: -15), CGSize(width: 0, height: -80)
            ]
        }
    }
}
