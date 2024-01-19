//
//  TargetDependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 11/6/23.
//

import ProjectDescription

public extension TargetDependency {
    enum Project {}
}

public extension TargetDependency.Project {
    static let Common = TargetDependency.project(target: "Common", path: .relativeToRoot("Projects/Common"))
    static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Core"))
    static let Feature = TargetDependency.project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
    static let Data = TargetDependency.project(target: "Data", path: .relativeToRoot("Projects/Data"))
    static let Domain = TargetDependency.project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    static let Presentation = TargetDependency.project(target: "Presentation", path: .relativeToRoot("Projects/Presentation"))
}

