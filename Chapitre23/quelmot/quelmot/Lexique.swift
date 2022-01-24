//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 23. Quels sont les styles d’applications et comment les construit-on ?
//======================================================================================

import Foundation
// Structure Lexique dans le fichier Lexique.swift
struct Lexique {
    static let joker: Character = "."
    let listeDeMots: [String]
    
    let ignoreLaCasse: Bool
    
    // Initialiseur personnalisé implémenté pour Lexique
    init(repertoireDesMots: String, ignoreLaCasse: Bool) throws {
        let contenuListeDeMots = try String(contentsOfFile: repertoireDesMots)
        listeDeMots = contenuListeDeMots.components(separatedBy: .newlines)
        self.ignoreLaCasse = ignoreLaCasse
    }
    
    // Méthode d'assistance pour la correction de la casse dans un mot
    private func corrigeLaCasse(_ valeur: String) -> String {
        ignoreLaCasse ? valeur.lowercased() : valeur
    }
    
    // Méthode d'assitance privée pour tester les correspondances
    private func correspond(modele: String, avec mot: String) -> Bool {
        guard modele.count == mot.count  else {
            return false
        }
        return modele.indices.allSatisfy { indice in
             modele[indice] == Lexique.joker || modele[indice] == mot[indice]
        }
    }
    
   
    
    // Méthode pour trouver les mots qui correspondent à un modèle de chaînes de caractères donné
    
//    func trouveLesMotsCorrespondants(au modele: String) -> [String] {
//        return listeDeMots.filter { candidat in
//            correspond(modele: modele, avec: candidat)
//        }
//    }
    // Nouvelle version avec correction de la casse dans les mots
    func trouveLesMotsCorrespondants(au modele: String) -> [String] {
        return listeDeMots.filter { candidat in
            correspond(modele: corrigeLaCasse(modele), avec: corrigeLaCasse(candidat))
        }
    }
}


