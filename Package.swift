// swift-tools-version:5.10

// © 2018–2024 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v15),
                                  .macOS(.v13)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText",
                                        swiftSettings: swiftSettings)],
                      swiftLanguageVersions: [.version("5")])
