import PackageDescription

let package = Package(
    name: "KueryDemo",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", majorVersion: 0),
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", majorVersion: 0)
    ]
)