// swift-tools-version: 6.2

// © 2018–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText"),
                                .testTarget(name: "XestiTextTests",
                                            dependencies: [.target(name: "XestiText")])],
                      swiftLanguageModes: [.v6])

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}
