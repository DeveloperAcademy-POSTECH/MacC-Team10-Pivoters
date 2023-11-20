//
//  Project.swift
//  Macc-Team10-PivotersManifests
//
//  Created by 한지석 on 11/6/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "App"

let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSPhotoLibraryAddUsageDescription" : "이미지를 사진 라이브러리로 내보낼 수 있습니다."
]

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 bundleId: "app",
                                 infoPlist: .extendingDefault(with: infoPlist),
                                 resources: ["Resources/**"],
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature
                                 ])
