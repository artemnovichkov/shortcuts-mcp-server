// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shortcuts-mcp-server",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .executable(name: "shortcuts-mcp-server", targets: ["ShortcutsMCPServer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk", from: "0.9.0"),
        .package(url: "https://github.com/swiftlang/swift-subprocess.git", branch: "main")
    ],
    targets: [
        .executableTarget(name: "ShortcutsMCPServer", dependencies: [
            .product(name: "MCP", package: "swift-sdk"),
            .product(name: "Subprocess", package: "swift-subprocess")
        ]),
    ]
)
