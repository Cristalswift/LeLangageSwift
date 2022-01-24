//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 23. Quels sont les styles d’applications et comment les construit-on ?
//======================================================================================

import Foundation
import ArgumentParser

// Test de Lexique dans le fichier main.swift
struct QuelMot: ParsableCommand {


//    func execute() throws {
//   //     let motsDeTest = ["Jean", "jean", "jeux", "jets", "jeanne", "jeannette", "jérémie"]
//
//   //     let lexique = Lexique(listeDeMots: motsDeTest)
//   //     let lexique = Lexique(listeDeMots: motsDeTest, ignoreLaCasse: true)
//
//        // Accès au répertoire des mots sous Mac
//        let chemin = "/usr/share/dict/words"
//        let lexique = try Lexique(repertoireDesMots: chemin, ignoreLaCasse: true)
//
//        // Amélioration à apporter à QuelMot
//        let args = CommandLine.arguments                        // Ajout
//        print("Arguments en lignes de commandes : \(args)")     // Ajout
//
//
//        // let modele = "je.."
//        // Remplacé par
//        let modele: String
//        if args.count > 1 {
//            modele = args[1]
//        } else {
//           print("Saisir le modèle de mot:", terminator: "")
//            modele = readLine() ?? ""
//        }
//
//        let correspondances = lexique.trouveLesMotsCorrespondants(au: modele)
//        print("Voici le résultat : \(correspondances.count) correspondances")
//        for mot in correspondances {
//            print(mot)
//        }
//
//
//        }
    // L'implémentation finale de la méthode execute()
    func execute() throws {
    // Accès au répertoire des mots sous Mac
        let chemin = "/usr/share/dict/words"
        let lexique = try Lexique(repertoireDesMots: chemin, ignoreLaCasse: true)

        let args = CommandLine.arguments
        print("Arguments en lignes de commandes : \(args)")
        
        // Code de l'analyse conditionnelle
        if args.count > 1 {
            let modele = args[1]
            trouveEtImprimeLesCorrespondances(pour: modele, selon: lexique)
        } else {
            while true {
                print("Saisir le modèle de mot :", terminator: "")
                let modele = readLine() ?? ""
                if modele.isEmpty { return }
                trouveEtImprimeLesCorrespondances(pour: modele, selon: lexique)
            }
        }
    }
    // Application de wrapper de propriété @Argument à la variable modele
    @Argument(help: """
                    Le modèle de mot à rechercher avec \(Lexique.joker) comme \
                    espace réservé. Si vous laissez ce espace vide, vous entrerez en mode interactif
                    """)
    var modele: String?
    
    // Déclaration de l'indicateur permettant d'ignorer la casse dans les mots
    @Flag(name: .shortAndLong, help: "Prise en charge de l'ignorance de la casse")
    var ignoreLaCasse: Bool = false
   
    // Déclaration de la propriété permettant de récupérer des mots
    @Option(name: .customLong("fichierdemot"), help: "Chemin vers la liste de mots")
    var cheminDeLaListeDeMots: String = "/usr/share/dict/words"
    
    
    func run() throws {
    // Accès au répertoire des mots sous Mac
       // let chemin = "/usr/share/dict/words"
        let lexique = try Lexique(repertoireDesMots: cheminDeLaListeDeMots, ignoreLaCasse: ignoreLaCasse)

        let args = CommandLine.arguments
        print("Arguments en lignes de commandes : \(args)")
        
        // Code de l'analyse conditionnelle

            if let modele = modele {
            trouveEtImprimeLesCorrespondances(pour: modele, selon: lexique)
        } else {
            while true {
                print("Saisir le modèle de mot :", terminator: "")
                let modele = readLine() ?? ""
                if modele.isEmpty { return }
                trouveEtImprimeLesCorrespondances(pour: modele, selon: lexique)
            }
        }
    }
    
    func trouveEtImprimeLesCorrespondances(pour modele: String, selon lexique: Lexique) {
        let correspondances = lexique.trouveLesMotsCorrespondants(au: modele)
        print("Voici le résultat : \(correspondances.count) correspondances")
        for reponse in correspondances {
            print(reponse)
        }
    }
}

// Ancien code pour l'exécution
//do {
//    try QuelMot().execute()
//} catch {
//    fatalError("L'application QuelMot s'est arrêtée de façon inattendue! \(error)")
//}

// Nouveau code pour l'exécution
QuelMot.main()
