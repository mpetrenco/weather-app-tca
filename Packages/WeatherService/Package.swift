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
    dependencies: [
        .package(path: "../Networking")
    ],
    targets: [
        .target(
            name: "WeatherService",
            dependencies: [
                "Networking"
            ]
        ),
        .testTarget(
            name: "WeatherServiceTests",
            dependencies: ["WeatherService"]
        )
    ]
)
