// swift-tools-version:4.2

// © 2018 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiText",
                      products: [.library(name: "XestiText",
                                          targets: ["XestiText"])],
                      targets: [.target(name: "XestiText")])