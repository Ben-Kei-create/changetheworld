// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TERRA",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "TERRA", targets: ["TERRA"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "TERRA",
            path: "Sources/TERRA",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TERRATests",
            dependencies: ["TERRA"],
            path: "Tests/TERRATests"
        )
    ]
)
