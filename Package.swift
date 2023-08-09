// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MotorwayAnalytics",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MotorwayAnalytics",
            targets: ["MotorwayAnalytics"])
    ],
    dependencies: [
      // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DataDog/dd-sdk-ios", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.6.0")),
        .package(url: "https://github.com/snowplow/snowplow-ios-tracker", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
              name: "MotorwayAnalytics",
              dependencies: [
                .product(name: "Datadog", package: "dd-sdk-ios"),
                .product(name: "DatadogCrashReporting", package: "dd-sdk-ios"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "SnowplowTracker", package: "snowplow-ios-tracker")
              ]),
        .testTarget(
            name: "MotorwayAnalyticsTests",
            dependencies: ["MotorwayAnalytics"])
    ]
)
