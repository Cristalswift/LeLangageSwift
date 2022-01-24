// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
//=================================================================================
// Le langage Swift : Apprendre la Programmation avec méthode, Clarté et Concision
// Les Éditions Cristalswift
// © 2022 Igor AGBOSSOU
// Chapitre 22. Comment organiser vos APIs grâce aux outils SPM intégrés à Xcode ?
//=================================================================================
import PackageDescription

let package = Package(
    name: "MonSwiftPackage",
    products: [
        .library(name: "MonSwiftPackage", targets: ["MonSwiftPackage"]),
    ],
    dependencies: [
        // Ajout du package swift-Numerics fourni par Apple, comme dépendance
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0")
    ],
    targets: [
       // Définition de la cible visée
        .target(name: "MonSwiftPackage",
                dependencies: [.product(name: "Numerics", package: "swift-numerics")]),
          
        .testTarget( name: "MonSwiftPackageTests", dependencies: ["MonSwiftPackage"])
        ]
)
