//
//  Target+extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 11/6/23.
//

import ProjectDescription

extension Target {
  public static func make(
      name: String,
      platform: Platform = .iOS,
      product: Product,
      bundleId: String,
      deploymentTarget: DeploymentTarget = .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: InfoPlist? = .default,
      sources: SourceFilesList,
      resources: ResourceFileElements? = nil,
      dependencies: [TargetDependency] = [],
      settings: Settings? = nil,
      scripts: [TargetScript] = []
    ) -> Target {
      return Target(
        name: name,
        platform: platform,
        product: product,
        bundleId: bundleId,
        deploymentTarget: deploymentTarget,
        infoPlist: infoPlist,
        sources: sources,
        resources: resources,
        scripts: scripts,
        dependencies: dependencies,
        settings: settings
      )
    }
}

