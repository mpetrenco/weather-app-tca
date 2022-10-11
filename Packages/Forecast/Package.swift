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
        .package(path: "../WeatherService"),
        .package(path: "../Resources"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git",
                 from: "0.41.2"),
        .package(url: "https://github.com/pointfreeco/composable-core-location.git",
                 from: "0.2.0")
    ],
    targets: [
        .target(
            name: "Forecast",
            dependencies: [
                "WeatherService",
                "Resources",
                .product(name: "ComposableArchitecture",
                         package: "swift-composable-architecture"),
                .product(name: "ComposableCoreLocation",
                         package: "composable-core-location"),
            ]
        ),
        .testTarget(
            name: "ForecastTests",
            dependencies: [
                "Forecast",
            ]
        ),
    ]
)
