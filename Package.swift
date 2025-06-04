// swift-tools-version: 6.1

// © 2018–2025 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      platforms: [.iOS(.v15),
                                  .macOS(.v13)],
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText")],
                      swiftLanguageModes: [.version("6")])
