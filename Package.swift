// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Stripe",
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-alpha"),
        .package(url: "https://github.com/ksmandersen/StripeKit.git", .branch("feature/events")),
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["Vapor","StripeKit"]),
        .testTarget(name: "StripeTests", dependencies: ["Vapor", "Stripe","StripeKit"])
    ]
)
