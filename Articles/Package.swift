// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Articles",
	platforms: [.macOS(SupportedPlatform.MacOSVersion.v10_15), .iOS(SupportedPlatform.IOSVersion.v13)],
    products: [
        .library(
            name: "Articles",
			type: .dynamic,
            targets: ["Articles"]),
        .executable(name: "article-benchmark", targets: ["article-benchmark"])
    ],
    dependencies: [
		.package(url: "https://github.com/Ranchero-Software/RSCore.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-collections-benchmark", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Articles",
			dependencies: [
				"RSCore"
			]),
        .target(
            name: "article-benchmark",
            dependencies: [
                "Articles",
                .product(name: "CollectionsBenchmark", package: "swift-collections-benchmark")
            ]
        ),
	]
)
