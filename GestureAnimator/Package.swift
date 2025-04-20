// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "GestureAnimator",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "GestureAnimator", targets: ["GestureAnimator"]),
    ],
    targets: [
        .target(
            name: "GestureAnimator",
            dependencies: [],
            path: "Sources/GestureAnimator"
        ),
        .testTarget(
            name: "GestureAnimatorTests",
            dependencies: ["GestureAnimator"],
            path: "Tests/GestureAnimatorTests"
        )
    ]
)
