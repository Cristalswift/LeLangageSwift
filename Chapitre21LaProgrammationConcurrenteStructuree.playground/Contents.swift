//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 21. Comment pratiquer la programmation concurrente structurée ?
//======================================================================================

import _Concurrency // On peut auusi faire import SwiftUI ou import UIKit
import SwiftUI
import Foundation

//Créons un travail à l'íntérieur d'une Task puis un autre à l'extérieur

//Task {
//    print("Ce travail s'accomplit dans le cadre d'une tâche !")
//}
//print("Cet autre exécution se fait sur le main actor")

// Du code asynchrone à l'œuvre
//Task {
//    print("Ce travail s'accomplit à l'intérieur de Task !")
//    let calcul = (1...1000).reduce(0, +)
//    print("Le résultat de 1 + 2 + .... + 1000 à l'intérieur de Task est : \(calcul)" )
//}
//print("Ce message s'exécute à l'extérieur de Task, mais sur l'acteur principal")


//// Expérimentation de l'approche d'annulation de tâche
//let tache = Task {
//    print("Ce travail s'accomplit à l'intérieur de Task !")
//    let calcul = (1...1000).reduce(0, +)
//    try Task.checkCancellation()     // vérification coopérative des annulations
//    print("Le résultat de 1 + 2 + .... + 1000 à l'intérieur de Task est : \(calcul)" )
//}
//print("Ce message s'exécute à l'extérieur de Task, mais sur l'acteur principal")
//tache.cancel()          // Annulation effective de la tâche

//Suspension d'une tâche en cours durant 5 secondes
//let tache = Task {
//    print("Ce travail s'accomplit à l'intérieur de Task !")
//    let calcul = (1...1000).reduce(0, +)
//    print("Dans 5 secondes, le résultat de 1 + 2 + .... + 1000 affichera" )
//    try await Task.sleep(nanoseconds: 5_000_000_000)
//    print("Calcul = \(calcul)")
//}

// ===== Mise en œuvre pratique de la syntaxe async / await

//Exemple de méthode pour télécharger des données depuis Internet
func telecharge(url: URL) async throws -> Data {
    
    let resultat = try await URLSession.shared.data(from: url)
    return resultat.0   // Les données
}


// Illustration d'une méthode asynchrone
func maMethode() async throws -> String {
    // Implémentation
    return "Resultat"
}

// Illustration d'une propriété calculée asynchrone
var maPropriete: String {
    get async {
        return "Propriété"
    }
}

// Illustration de la définition d'un closure asynchrone
//func maFonction(closure: (Int) async -> Int) -> Int {
//    // Implémentation
//
//}

// Illustration de la définition d'un indice asynchrone
//subscript(_ index: Int) -> String {
//    get async throws {
//        // Implémentation
//    }
//}


// Création du contexte asynchrone
Task {
    let maVariable = try await maMethode()
    print(maVariable)
    print("Je suis une propriété asynchrone : \(await maPropriete)")
        
    }

//Exemple d'application de la boucle asynchrone aux séquences asynchrones
func trouveInfoSurInternet(_ info: String, url: URL) async throws -> String? {
    for try await ligne in url.lines {
        if ligne.contains(info){
            return ligne.description
        }
    }
    return nil
}

Task {
    let monURL = URL(fileURLWithPath: "https://developer.apple.com/xcode/swiftui/")
    if let description = try await trouveInfoSurInternet("SwiftUI", url: monURL) {
        print(description)
    }
}

struct TexteAutomatique: AsyncSequence {
    typealias Element = String
    let phrase: String
    func makeAsyncIterator() -> TexteIterateur {
        return TexteIterateur(phrase)
    }
}

struct TexteIterateur: AsyncIteratorProtocol {
    typealias Element = String
    let phrase: String
    var index: String.Index
    
    init(_ phrase: String) {
        self.phrase = phrase
        self.index = phrase.startIndex
    }
    
    // Méthode importante
    mutating func next() async throws -> String? {
        guard index < phrase.endIndex else {
            return nil
        }
        try await Task.sleep(nanoseconds: 1_000_000_000) // Temps d'apparition de chaque lettre
        defer {
            index = phrase.index(after: index)
        }
        return String(phrase[phrase.startIndex...index])
    }
}

Task{
    for try await caractere in TexteAutomatique(phrase: "Bonjour, async/await !") {
        print(caractere)
    }
}
    

// Définition
var phrase = "Bonjour AsyncStream !"
var index = phrase.startIndex

let flux = AsyncStream<String> {
    guard index < phrase.endIndex else { return nil }
    do {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch { return nil}
    defer { index = phrase.index(after: index)}
    return String(phrase[phrase.startIndex...index])
}

// Exécution
Task {
    for try await caractere in flux {
        print(caractere)
        }
    }

// Téléchargement de deux images en parallèle
//func telechargeDeuxImagesEnParallele() async throws -> (Data, Data) {
//    // Les urls
//    let url1 = URL(string: "https://www.apeth.com/pep/manny.jpg")!
//    let url2 = URL(string: "https://www.apeth.com/pep/moe.jpg")!
//
//    // Téléchargements
//
//    let image1 = try await telecharge(url: url1)
//    let image2 = try await telecharge(url: url2)
//
//    return (image1, image2)
//
//}

// Exécution parallèle avec async let
//func executionParallele() async throws -> (Data, Data) {
//    // Les urls
//    let url1 = URL(string: "https://www.apeth.com/pep/manny.jpg")!
//    let url2 = URL(string: "https://www.apeth.com/pep/moe.jpg")!
//
//    // Téléchargements
//
//    async let image1 = telecharge(url: url1)
//    async let image2 = telecharge(url: url2)
//
//
//    return try await (image1, image2)
//}


// Quelques mauvais usages de la syntaxe async let
//async let niveauSuperieur = ... // Erreur: 'async let' définie dans une fonction ne supportant pas la concurrence
//
//func synchrone() { // Note: Ajouter 'async' à la fonction 'synchrone()' pour la rendre asynchrone
//  async let x = ... // Erreur: 'async let' définie dans une fonction ne supportant pas la concurrence
//}
//
//func synchroniseMoi(apres: () -> String) { ... }
//synchroniseMoi {
//  async let y = ... // Erreur: Conversion invalide de la fonction asynchrone de type '() async -> String' à une fonction synchrone de type'() -> String'
//}

// Utilité des types actor

class PlayListeMusicale {
    let intitule: String
    let proprietaire: String
    private(set) var musiques: [String]
    
    init(nom: String, auteur: String, titres: [String]) {
        intitule = nom
        proprietaire = auteur
        musiques = titres
    }
    
    func ajout(de titre: String) {
        musiques.append(titre)
    }
    
    func supprime(ce titre: String) {
        guard musiques.contains(titre), let index = musiques.firstIndex(of: titre) else {
            return
        }
            musiques.remove(at: index)
    }
    
    func recupere(_ titre: String, de playListe: PlayListeMusicale) {
        ajout(de: titre)
        playListe.supprime(ce: titre)
    }
    
    func transfere(_ titre: String, a playListe: PlayListeMusicale) {
        playListe.ajout(de: titre)
        supprime(ce: titre)
    }
}

//Définition d'un type avec des fonctionnalités asynchrones
actor ListeMusicale {   // Etape 1
    let intitule: String
    let proprietaire: String
    private(set) var musiques: [String]
    
    init(nom: String, auteur: String, titres: [String]) {
        intitule = nom
        proprietaire = auteur
        musiques = titres
    }
    
    func ajout(de titre: String) {
        musiques.append(titre)
    }
    
    func supprime(ce titre: String) {
        guard musiques.contains(titre), let index = musiques.firstIndex(of: titre) else {
            return
        }
            musiques.remove(at: index)
    }
    
    func recupere(_ titre: String, de playListe: ListeMusicale) async  {   // Etape 2
       
       await playListe.supprime(ce: titre)  // Etape 3
        ajout(de: titre)
    }
    
    func transfere(_ titre: String, a playListe: ListeMusicale) async {
        await playListe.ajout(de: titre)
        supprime(ce: titre)
    }
}

//// Exécution concurrente du code relatif au type actor
//let mesFavoris = ListeMusicale(nom: "Mes musiques", auteur: "Igor",
//                               titres: ["J'aime la vie",
//                                       "La vie est belle",
//                                       "Apprendre pour vivre",
//                                       "Tout ce qui a de la valeur"])
//let listeDeSoiree = ListeMusicale(nom: "Pour le show", auteur: "Fiacre",
//                                  titres: ["Zouk machine",
//                                          "Sensationnelle",
//                                          "allumez le feu !"])
//
//
//Task {
//    await mesFavoris.recupere("Zouk machine", de: listeDeSoiree)
//    await mesFavoris.transfere("Apprendre pour vivre", a: listeDeSoiree)
//    print(mesFavoris)
//}


//Utilité du mot-clé nonisolated
extension ListeMusicale: CustomStringConvertible {
    nonisolated var description: String {
        "\(intitule) par \(proprietaire)"
    }
}

// Adoption du protocole Sendable par une classe
final class Musique {
    let titre: String
    let auteur: String
    
    init(titre: String, auteur: String) {
        self.titre = titre
        self.auteur = auteur
    }
}

extension Musique: Sendable {}

// Exemples d'utilisation de l'attribut @sendable

// Exemple 1
func execute(travail: @escaping @Sendable () -> Void, avec priorite: TaskPriority? = nil) {
    Task(priority: priorite, operation: travail)
}

//Exemple 2
@Sendable func nombreAleatoire() {
    let nombre = Int.random(in: 1...10)
    print(nombre)
}

execute(travail: nombreAleatoire)
