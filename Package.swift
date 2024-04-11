// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LessonRenderer",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "LessonRenderer",
            targets: ["LessonRenderer"]),
    ],
    targets: [
        .target(
            name: "LessonRenderer"),
        .testTarget(
            name: "LessonRendererTests",
            dependencies: ["LessonRenderer"]),
    ]
)
