//
//  RefactoredTeam.swift
//  Core
//
//  Created by Eojin Choi on 11/15/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import SwiftData

@Model
public final class RefactoredTeam {
    public let id: UUID
    public let teamName: String
    public let subTitle: String

    public init(
        id: UUID,
        teamName: String,
        subTitle: String)
    {
        self.id = id
        self.teamName = teamName
        self.subTitle = subTitle
    }
}
