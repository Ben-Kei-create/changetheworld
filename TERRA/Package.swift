// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TERRA",
    defaultLocalization: "en",
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
            exclude: [
                "Resources/Info.plist",
                "Resources/TERRA.entitlements"
            ],
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
