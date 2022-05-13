// swift-tools-version:5.6

// © 2018–2022 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.macOS(.v11)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText")],
                      swiftLanguageVersions: [.version("5")])
