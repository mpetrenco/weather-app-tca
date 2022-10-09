// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "WeatherService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "WeatherService",
            targets: ["WeatherService"]),
    ],
    targets: [
        .target(
            name: "WeatherService"
        ),
        .testTarget(
            name: "WeatherServiceTests",
            dependencies: ["WeatherService"]
        )
    ]
)
