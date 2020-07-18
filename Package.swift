// swift-tools-version:5.2

// © 2018–2020 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.macOS(.v10_15)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText")],
                      swiftLanguageVersions: [.version("5")])
