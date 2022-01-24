//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 22. Comment organiser vos APIs grâce aux outils SPM intégrés à Xcode ?
//======================================================================================
import Foundation

//Ajout du module Numerics
import Numerics        // Pour la prise en charge des nombres complexes

extension Complex {
    /// Représentation textuelle de ce nombre complexe
    public var representation: String {
        get {
        let partieReelle = String("\(self.real)" + " + ")
        let partieImaginaire  = String("\(self.imaginary)" + "i")
        
        return partieReelle + partieImaginaire
        }
    }
}

