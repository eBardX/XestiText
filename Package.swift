// swift-tools-version: 6.2

// © 2018–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      dependencies: [.package(url: "https://github.com/swiftlang/swift-docc-plugin.git",
                                              .upToNextMajor(from: "1.1.0")),
                                     .package(url: "https://github.com/eBardX/XestiTools.git",
                                              branch: "v8-experimental")],
                      targets: [.target(name: "XestiText",
                                        dependencies: [.product(name: "XestiTools",
                                                                package: "XestiTools")]),
                                .testTarget(name: "XestiTextTests",
                                            dependencies: [.target(name: "XestiText")])],
                      swiftLanguageModes: [.v6])

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}
