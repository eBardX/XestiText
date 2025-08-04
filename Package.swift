// swift-tools-version: 5.10

// © 2018–2025 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText")],
                      swiftLanguageVersions: [.v5])

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}
