//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 22. Comment organiser vos APIs grâce aux outils SPM intégrés à Xcode ?
//======================================================================================
import XCTest
@testable import MonSwiftPackage

final class MonSwiftPackageTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MonSwiftPackage().text, "Hello, World!")
    }
}
