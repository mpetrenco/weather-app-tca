// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Forecast",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Forecast",
            targets: ["Forecast"]),
    ],
    dependencies: [
        .package(path: "../WeatherService")
    ],
    targets: [
        .target(
            name: "Forecast",
            dependencies: [
                "WeatherService"
            ]
        ),
        .testTarget(
            name: "ForecastTests",
            dependencies: ["Forecast"]),
    ]
)
