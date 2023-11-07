import ProjectDescription

extension Project {

    private static let organizationName = "com.pivoters."

    public static func makeModule(
        name: String,
        platform: Platform,
        product: Product,
        bundleId: String,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "17.0",
                                                  devices: .iphone),
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = [],
        target: Target? = nil
    )
    -> Project
    {

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: organizationName + bundleId,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: [.SwiftLintString],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "com.ofo.\(name)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])

        var targets: [Target] = [mainTarget, testTarget]

        if let target = target {
            targets.append(target)
        }

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }

}

