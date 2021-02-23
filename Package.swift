// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TableKit",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "TableKit",
            targets: ["TableKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TableKit",
            path: "TableKit/TableKit",
            sources: [
                "Protocol/Reusable.swift",
                "Protocol/TableControllerDelegate.swift",
                "Protocol/UITableViewReusable.swift",
                "Node.swift",
                "Row.swift",
                "Section.swift",
                "TableController.swift",
            ]
        ),
    ]
)
