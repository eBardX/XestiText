// swift-tools-version: 6.3

// © 2018–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText",
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiTextTests",
                                            dependencies: [.target(name: "XestiText")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageModes: [.v6])
