//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 8. Comment programmer avec les listes, les dictionnaires et les ensembles ?
//========================================================================================
import Combine

//================== Les tableaux =============================

// Les tableaux: création à partir d'un littéral

let tableauImmuableDePrenoms = ["Franck", "Georges", "Igor", "Pierre", "François", "Clément", "Fiacre", "Luc"]

print(type(of: tableauImmuableDePrenoms))  // Array<String>

// Inspection du nombre d'éléments du tableau
let nombreDElements = tableauImmuableDePrenoms.count // 8

// Première façon de créer un tableau vide

var tableauDeStringVide: [String] = []

// Deuxième façon de créer un tableau vide

var tableauDeDoubleVide = [Double]()

// Création d'un tableau avec l'initialisatue Array(repeating: count:)

var queDesZeros = Array(repeating: 0, count: 5) // [0, 0, 0, 0, 0]

// Création d'un tableau à partir d'un autre avec Array(_:)

var tableauModifiable = Array(tableauImmuableDePrenoms)

print(tableauModifiable.first as Any)  // Optional("Franck")

var  premierElement = ""
// On récupère le premier éléement par liaison otptionnelle
if let premier = tableauModifiable.first {
    premierElement = premier
}

print(premierElement)  // Franck.

var plusPetiteValeur = ""
if let petite = tableauModifiable.min() {
    plusPetiteValeur = petite
}
print(plusPetiteValeur) // Clément

// Autres exemples de first et min()

print([4, 8, 9].first as Any)   // Optional(4)
print([4, 8, 1].min() as Any)   // Optional(1)

// Accession aux éléments par la syntaxe des indices

premierElement = tableauModifiable[0]           // Franck
var quatriemeElemnent = tableauModifiable[3]    // Pierre

//let erreur = tableauModifiable[8]

// Accéder à des groupes d'éléments d'une collection
let quatreASept = tableauModifiable[3...6]
print(quatreASept)      // ["Pierre", "François", "Clément", "Fiacre"]
print(quatreASept[3])   // Pierre

// Quel est le type de quatreAsept ?
print(type(of: quatreASept))    // ArraySlice<String>

//print(quatreASept[0])   // ERREUR !
// Créer un nouveau tableau à partir du groupe d'éléments
var nouveauTableau = Array(quatreASept)
print(nouveauTableau[0])    // Pierre


// Vérifier l'appartenance d'un élément au contenu de la collection
func faitPartieDeMesAmis(qui: String) -> Bool {
    tableauModifiable.contains(qui)
}

print(faitPartieDeMesAmis(qui: "Jean"))     // false
print(faitPartieDeMesAmis(qui: "Fiacre"))   // true

// Application du test de vérification d'appartenance au type ArraySlice
quatreASept.contains("Georges")         // false
quatreASept.contains("Clément")         // true

//Ajout d'éléments à un tableau

// Utilisation de la méthode append(_ newElement: String)
tableauModifiable.append("Alice")
print(tableauModifiable)

// Utilisation de la surcharge générique, append<S>(contentsOf newElements: S)
tableauModifiable.append(contentsOf: ["Jeanne", "Rachel", "Elsa"])
print(tableauModifiable)

// Utilisation de l'opérateur +=
tableauModifiable += ["Aline"]
print(tableauModifiable)

// Insertion de valeurs dans un tableau

// Utilisation de la méthode insert(_ newElement: String, at i: Int)
tableauModifiable.insert("Sandrine", at: 4)
print(tableauModifiable)

// Utilisation de la surcharge générique, insert<C>(contentsOf newElements: C, at i: Int)
tableauModifiable.insert(contentsOf: ["Hélène", "Corine"], at: 7)
print(tableauModifiable)

// Mise à jour d'une valeur dans un tableau

print(tableauModifiable[5])     // François
// Mise à jour : remplacement de François par Sabine
tableauModifiable[5] = "Sabine"
print(tableauModifiable[5])     // Sabine

//Mise à jour de plusieurs valeurs d'une portion du tableau
print(tableauModifiable[3...5])     // ["Pierre", "Sandrine", "Sabine"]

// Remplacement de ["Pierre", "Sandrine", "Sabine"] par ["Chloé", "Charline", "Edouard"]
tableauModifiable.replaceSubrange(3...5, with: ["Chloé", "Charline", "Edouard"])
print(tableauModifiable[3...5])     // ["Chloé", "Charline", "Edouard"]

// Remplacement des trois premières valeurs par ["Alin", "Bertrand", "Salomon"]
tableauModifiable[0..<3] = ["Alin", "Bertrand", "Salomon"]
print(tableauModifiable[0...2])     // ["Alin", "Bertrand", "Salomon"]

// Illustration d'une situation où le nombre de valeurs transmises est
// inférieur au nombre d'éléments indiqués par l'opérateur de plage
var tableauContenantCinqValeurs = [0,1,2,3,4]
// Remplacement de 1 par 12 et de 2 par 12. Suppression de 3
tableauContenantCinqValeurs[1...3] = [12,13]
// Le tableau mis à jour. Il compte à présent 4 éléments au lieu des cinq de départ
print(tableauContenantCinqValeurs) // [0, 12, 13, 4]

//=======================================================================

// Illustration d'une situation où le nombre de valeurs transmises est
// supérieur au nombre d'éléments indiqués par l'opérateur de plage
var autreTableauContenantCinqValeurs = [5,6,7,6,9]
// Remplacement de 5 par 12, de 6 par 13, et de 7 par 14. Insertion de 15 à l'indice 4
autreTableauContenantCinqValeurs[1...3] = [12,13,14,15]
// Le tableau mis à jour. Il compte à présent 6 éléments au lieu des cinq de départ
print(autreTableauContenantCinqValeurs)     // [5, 12, 13, 14, 15, 9]

//=======================================================================

// Supression d'un ou plusieurs éléments d'un tableau
var tableauAExperimenter = tableauModifiable
print(tableauAExperimenter)
print(tableauAExperimenter.capacity) // La capacité actuelle est de 16

tableauAExperimenter.removeFirst(2) // Suppression des deux premiers éléments
print(tableauAExperimenter)

tableauAExperimenter.removeLast(5)  // Suppression des deux derniers éléments
print(tableauAExperimenter)

tableauAExperimenter.removeSubrange(2...4) // Suppression des éléments à indices 2 à 4
print(tableauAExperimenter)
// Suppression de tous noms comportant la lettre "i".
tableauAExperimenter.removeAll {$0.contains("i")}
print(tableauAExperimenter)

// Suppression de tous les éléments du tableau avec conservation de sa capacité
tableauAExperimenter.removeAll(keepingCapacity: true) // On conserve sa capacité.
print(tableauAExperimenter.capacity)

//=======================================================================

// Extraction d'un élément d'un tableau

var tableauPourExtraction = tableauModifiable
print(tableauPourExtraction)

// Extraction du premier élément
let premierExtrait = tableauPourExtraction.removeFirst()

// Extraction du dernier élément
let dernierExtrait = tableauPourExtraction.removeLast()
print(tableauPourExtraction)

// Extraction du 5éme élément: Edouard
let unExtrait = tableauPourExtraction.remove(at: 4)

tableauPourExtraction.popLast()
print(tableauPourExtraction)


//=======================================================================

// Exclusion des premiers et derniers éléments d'un tableau

var tableauPourExclusion = tableauModifiable
print(tableauModifiable)
let exclusionDes2Premiers = tableauPourExclusion.dropFirst(2)
print(exclusionDes2Premiers)
let exclusionDes5Derniers = tableauModifiable.dropLast(5)
print(exclusionDes5Derniers)

// Itéeration sur les éléments d'un tableau

// Impression de chaque élément du tableau
for element in tableauModifiable {
    print(element)
}
// Impression de chaque indice avec la valeur sur laquelle il pointe
for (indice, element) in tableauModifiable.enumerated() {
    print("L'indice \(indice) pointe sur la valeur -> \(element)")
}

// Algorithme de tri avec les méthodes sort() et sorted()
print(tableauModifiable)

let tableauTrieEnRetrourAvecSorted = tableauModifiable.sorted()
print(tableauTrieEnRetrourAvecSorted)
print(tableauModifiable)    // Le tableau original est resté inchangé.

let tableauTrieEnRetourAvecSortedBy = tableauModifiable.sorted { $0 > $1}
print(tableauTrieEnRetourAvecSortedBy)

tableauModifiable.sort()    // Tri par ordre alphabétique
print(tableauModifiable)

tableauModifiable.sort { $0 > $1 }  // Trie par ordre décroissant
print(tableauModifiable)

// Algorithme de filtrage
 let tousLesPrenomsContenantLaLettreI = tableauModifiable.filter { $0.contains("i")}
print(tousLesPrenomsContenantLaLettreI)

// Algorithme de transformation map()

print(tableauModifiable)

// Nouveau tableau avec tous les prénoms en lettres majuscules
let tousLesPrenomsEnMajuscule = tableauModifiable.map {
    $0.uppercased()
}
print(tousLesPrenomsEnMajuscule)
print(tableauModifiable)

// Nouveau tableau contenant le nombre de lettres de chaque prénom
let longueurDesPrenoms = tableauModifiable.map {
    $0.count
}
print(longueurDesPrenoms)
print("longueurDesPrenoms est de type : \(type(of: longueurDesPrenoms))")

// Algorithme d'itération forEach()

tableauModifiable.forEach {
    print($0)
}

// =================== Travail avec les Dictionnaires ==================

// Création et initialisation à vide par inférence de type
var dictParInference = [String: String]()

// Création et initialisation à vide par annotation de type
var dictParAnnotation : [Int: String] = [:]

// Création de notre exemple
var monDictionnaire = ["Igor": 16,
                       "Franck": 12,
                       "Aline": 12,
                       "Georges": 19,
                       "Sandrine": 16]

// Accès aux valeurs dans un dictionnaire
let noteDeSandrine = monDictionnaire["Sandrine"]    // Optional(16)
print(noteDeSandrine as Any)
type(of: noteDeSandrine)    // Optional<Int>

// Tentative d'accès à une valeur qui n'existe pas !
print(monDictionnaire["Alice"] as Any) // N'existe pas ! Donc, nil

// Récupération par liaison optionnelle
var noteDeFranck = 0
if let note = monDictionnaire["Franck"] {
    noteDeFranck = note
}

print(noteDeFranck)       // 16
type(of: noteDeFranck)    // Int

// Utilisation des propriétés count et isEmpty

print("Notre collection contient \(monDictionnaire.count) paires")
print("Notre collection contient est-ele vide ? \(monDictionnaire.isEmpty)")

// Comment mettre à jour le contenu d'un dictionnaire?
// Modification d'une valeur par la syntaxe d'indexation
monDictionnaire["Igor"] = 18
print(monDictionnaire)

// Modification d'une valeur par la méthode updateValue
let nouvelleNoteDeGeorges = monDictionnaire.updateValue(20, forKey: "Georges")

print(nouvelleNoteDeGeorges!)
print(monDictionnaire)

// Ajout d'une nouvelle paire clé-valeur
monDictionnaire["Luc"] = 17
print(monDictionnaire)

monDictionnaire.updateValue(11, forKey: "Jean")
print(monDictionnaire)

// Opérations de suppression relatives à un dictionnaire
// Syntaxe d'indexation
print(monDictionnaire)
monDictionnaire["Luc"] = nil
print(monDictionnaire)

// Méthode removeValue
if let valeurSupprimee = monDictionnaire.removeValue(forKey: "Igor") {
    print("La valeur \(valeurSupprimee), associée à la clé Igor, est supprimée")
}
print(monDictionnaire)

var copieDeMonDictionnaire = monDictionnaire

// Suppression de tout le contenu de la collection
copieDeMonDictionnaire.removeAll()
print(copieDeMonDictionnaire)

//Techniques d'itération relatives à un dictionnaire
// 1- Itération par paire clé-valeur avec la boucle for..in
for (clé, valeur) in monDictionnaire {
    print("La note de : \(clé) est : \(valeur)" )
}

// 2- Itération par paire clé-valeur avec la closure forEach
monDictionnaire.forEach { (clé, valeur) in
    
    print("La note de : \(clé) est : \(valeur)" )
}

// 3- Itération à partir des indices de la séquence du tableau sous-jacent
for (indice, paire) in monDictionnaire.enumerated() {
    print("L'indice : \(indice) pointe sur la paire clé-valeur : \(paire)" )
}

// 4- Iteration sur les clés d'un dictionnaire
let tableauDesCles = monDictionnaire.keys
for cle in tableauDesCles {
    print(cle)
}

// 5- Itération sur les valeurs d'un dictionnaire
let tableauDesValeurs = monDictionnaire.values
for valeur in tableauDesValeurs {
    print(valeur)
}

// =========== Comment programmer avec les ensembles: le type Set ================
//Techniques de création et d'initialisation d'un ensemble
// 1- Création d'un ensemble vide
var voyelles = Set<Character>()
print("voyelles est de type \(type(of: voyelles)) et contient \(voyelles.count) éléments.")

// Initialisation de l'ensemble
let resultat = voyelles.insert("a")
print(resultat)
print(voyelles)

// Remise à zéro de l'ensemble
voyelles = []
print("voyelles est de type \(type(of: voyelles)) et contient \(voyelles.count) éléments.")

// 2- Création et initialisation par la syntaxe littérale d'un tableau avec annotation de type explicite
let mes4Presidents: Set<String> = ["Emmanuel Macron", "François Hollande", "Nicolas Sarkozy", "Jacques Chirac"]
print("mes4Presidents est de type \(type(of: mes4Presidents)) et contient \(mes4Presidents.count) éléments.")

// 3- Création et initialisation par la syntaxe littérale d'un tableau avec annotation de type implicite
let lesChiffresDeLaBase10: Set = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print("lesChiffresDeLaBase10 est de type \(type(of: lesChiffresDeLaBase10))")

// Opérations sur les ensembles de type Set<Int>
let chiffresPairs: Set = [0, 2, 4, 6, 8]
let chiffresImpairs: Set = [1, 3, 5, 7, 9]
let chiffresPremiers: Set = [2, 3, 5, 7]

let tousLesChiffres = chiffresPairs.union(chiffresImpairs)
print(tousLesChiffres.sorted())  // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

let chiffresPremiersEtImpairs = chiffresImpairs.intersection(chiffresPremiers)
print(chiffresPremiersEtImpairs)   // [3, 5, 7]

let chiffresNiPremiersNiImpaires = chiffresPremiers.symmetricDifference(chiffresImpairs)
print(chiffresNiPremiersNiImpaires) // [1, 9, 2]

let chiffresImpairesNonPremiers = chiffresImpairs.subtracting(chiffresPremiers)
print(chiffresImpairesNonPremiers)  // [9, 1]

// Test de chevauchement entre ensembles

// Test d'égalité en deux ensembles
print(tousLesChiffres == chiffresImpairs) // false

// Test d'inclusion totale (A contient B)
print(tousLesChiffres.isSuperset(of: chiffresImpairs))  // true
print(tousLesChiffres.isStrictSuperset(of: chiffresImpairs)) // true

// Test d'inclusion totale (A est inclus dans B)
print(chiffresPremiers.isSubset(of: tousLesChiffres))   // true
print(chiffresPairs.isStrictSubset(of: tousLesChiffres))      // true

// Test d'inclusion stricte
print(tousLesChiffres.isStrictSuperset(of: tousLesChiffres)) // false
print(tousLesChiffres.isSuperset(of: tousLesChiffres))      // true
print(tousLesChiffres.isSubset(of: tousLesChiffres))        // true
print(tousLesChiffres.isStrictSubset(of: tousLesChiffres))  // false

// Test de disjonction
print(chiffresImpairs.isDisjoint(with: chiffresPairs))      // true
