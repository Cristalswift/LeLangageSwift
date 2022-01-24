//===================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 14. Comment appliquer la programmation orientée protocole à vos types ?
//====================================================================================

//Définition et implémenttion de la conception orientée protocole de la figure 14.1

// Définition du type Point comme struct
struct Point {
   var abscisse: Double
   var ordonnee: Double
}

// Définition du type Couleur comme enum
public enum Couleur {
    case bleu, vert, rouge, jaune, orange, magenta
}

protocol Geometrie {
    var centre: Point { get set}
    func perimetre() -> Double
    func surface() -> Double
}

protocol Texturable {
    var remplissage: Couleur { get }
    var contour: Couleur { get}
    
    mutating func coloriage(avec ceci: Couleur)
    mutating func delimitation(avec cela: Couleur)
}

// Extension du protocole Texturable
extension Texturable {
   // Ajout et implémentation de la propriété texture
    public var texture: (Couleur, Couleur) {
        (remplissage, contour)
    }
}

protocol Polygone: Geometrie, Texturable {
    var sommets: [Point] { get set}
    associatedtype TypeAssocie
    func description() -> TypeAssocie
}

typealias Graphisme = Geometrie & Texturable


// Définition et implémentation de Cercle
struct Cercle: Graphisme {
    var rayon: Double
    var centre: Point
    var remplissage: Couleur = Couleur.jaune
    var contour: Couleur = Couleur.bleu
    
    mutating func coloriage(avec ceci: Couleur) {
        remplissage = ceci
    }
    
    mutating func delimitation(avec cela: Couleur) {
        contour = cela
    }
    
    func perimetre() -> Double {
        2 * rayon * Double.pi
    }
    
    func surface() -> Double {
        rayon * rayon * Double.pi
    }
}

// Définition et implémentation de Ellipse
struct Ellipse: Graphisme {
    var centre: Point
    var remplissage: Couleur
    var contour: Couleur
    var petitAxe: Double
    var grandAxe: Double
    
    mutating func coloriage(avec ceci: Couleur) {
        remplissage = ceci
    }
    
    mutating func delimitation(avec cela: Couleur) {
        contour = cela
    }
    
    func perimetre() -> Double {
        
        // Clacul d'après la formule classique : 2∏*RacineCarrée((aˆ2 + bˆ2)/2)
        2 * Double.pi * (((petitAxe * petitAxe + grandAxe * grandAxe)/2).squareRoot())
    }
    
    func surface() -> Double {
        Double.pi * petitAxe * grandAxe
    }
}
//Définition et implémentation du type Carre
struct Carre: Polygone {
    
    var cote: Double                                    // à définir dans l'initialiseur
    var sommets: [Point]                                // à définir dans l'initialiseur
    var centre: Point = Point(abscisse: 0, ordonnee: 0) // valeur par défaut
    var contour: Couleur = Couleur.rouge                // valeur par défaut
    var remplissage: Couleur = Couleur.orange           // valeur par défaut
    
    // Désignation du type concret que représente TypeAssocie
    typealias TypeAssocie = String
    
    // Implémentation de la méthode description()
    func description() -> String {
        let nomDuType = "Je suis de type " + String("\(type(of: self))")
        let surface = "Ma superficie mesure : " + String("\(surface())")
        let perimetre = "Mon pourtour est de " + String("\(perimetre())")
        
        let desc = """
                            Je me présente :
                            \(nomDuType)
                            \(surface)
                            \(perimetre)
                            """
        print(desc)
        return desc
    }
    // ... La suite de l'implémentation de Carre
    
    mutating func coloriage(avec ceci: Couleur) {
        remplissage = ceci
    }
    
    mutating func delimitation(avec cela: Couleur) {
        contour = cela
    }
    
    func perimetre() -> Double {
        4 * cote
    }
    
    func surface() -> Double {
        cote * cote
    }
}

// Test de fonctionnement du carré
let point1 = Point(abscisse: -2, ordonnee: 2)
let point2 = Point(abscisse: 2, ordonnee: 2)
let point3 = Point(abscisse: 2, ordonnee: -2)
let point4 = Point(abscisse: -2, ordonnee: -2)
var carre = Carre(cote: 4, sommets: [point1, point2, point3, point4])

carre.description() // Je suis de type Carre


// Exemple de type existentiel: Geometrie
var uneGeometrie: Geometrie = Cercle(rayon: 4, centre: point1)

// Exemple de type non-existentiel: Polygone
//var uneCarre: Polygone = Carre(cote: 4, sommets: [point1, point2, point3, point4])

// Expérimentation de l'effacement de type
let suite = Array(1...10)
let ensemble = Set(20...30)
let suiteInverse = suite.reversed()

for s in suiteInverse {
    print(s)
}

let maCollection = [suite, ensemble, suiteInverse] as [Any]
for s in maCollection {
    print(s)
}

let collectionHomogene = [suite, Array(ensemble), Array(suiteInverse)]
print(collectionHomogene)
let total = collectionHomogene.flatMap{$0}.reduce(0, +)
print(total)    // 385

let collection = [AnyCollection(suite), AnyCollection(ensemble), AnyCollection(suiteInverse)]

//Pour que vous remarquiez le type de chaque bloc de la collection
for vrai in collection {
    print(vrai)
}

let somme = collection.flatMap { $0 }.reduce(0, +)
    print(somme)            // 385


//==== Introduction au type opaque =====

// Type opaque de retour
func retourneUneValeurEntiere() -> some FixedWidthInteger {
    55
}

let valeur = retourneUneValeurEntiere() // 55

// Ce code ne pas être compilé car, confusion sur le type de retour !!!
//func renvoieUnEntierAuHasard() -> some FixedWidthInteger {
//    if Bool.random() {
//        return Int(100)
//    } else {
//        return Int8(90)
//    }
//}


func renvoieUnEntierAuHasard() -> some FixedWidthInteger {
    if Bool.random() {
        return Int(100)
    } else {
        return Int(90)
    }
}

let entier1 = renvoieUnEntierAuHasard()
let  entier2 = renvoieUnEntierAuHasard()
