// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Bapfs",
    products: [
        .executable(
            name: "Bapfs",
            targets: ["Bapfs"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0"),
        .package(name: "SassPublishPlugin", url: "https://github.com/hejki/sasspublishplugin", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Bapfs",
            dependencies: [
                "Publish",
                "SassPublishPlugin"
            ]
        )
    ]
)
