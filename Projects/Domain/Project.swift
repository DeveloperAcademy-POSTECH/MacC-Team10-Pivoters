//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 1/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "Domain"

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .staticFramework,
                                 bundleId: "Domain",
                                 dependencies: [.Project.Core])
