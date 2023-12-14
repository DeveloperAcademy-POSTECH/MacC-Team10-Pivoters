//
//  Uniform.swift
//  Core
//
//  Created by 한지석 on 12/3/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation

public enum Uniform: Int, Codable {
    case plain1
    case stripe1
    case plain2
    case stripe2
    case stripe3
    case seperate1
    case seperate2

    public static let uniformArray: [Uniform] = [.plain1, .stripe1, .plain2, .stripe2, .stripe3, .seperate1, .seperate2]
}

public struct UniformColor: Codable {
    public var red: Double
    public var green: Double
    public var blue: Double

    public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
