//===================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 15. Extension de type, opérateurs personnalisés, indications et routage
//====================================================================================
 
import Foundation

extension Numeric {
    /// Renvoie le carré de la valeur
    var squared: Self {
    self * self
    }
}

let intAuCarre = 13.squared         // 169
let doubleAuCarre = 13.5.squared    // 182.25


extension Int {
    /// Renvoie le carré de la valeur
    var auCarre: Int {
        self * self
    }
}
let carreDe9 = 9.auCarre    // 81

struct Vehicule {
   let marque: String
   let modele: String
   let annee: Int
    
   var jaugeEnergie: Double {
    willSet{
       precondition(newValue >= 0.0 && newValue <= 1.0, "La valeur doit être entre 0 et 1")
        }
    }
}

// Utilisation de l'Extension pour se comformer à un protocole
extension Vehicule: CustomStringConvertible {
    var description: String {
        return "\(marque) \(modele) \(annee) avec une jauge de \(jaugeEnergie)"
    }
}

let toyota = Vehicule(marque: "Toyota", modele: "Avensis", annee: 2008, jaugeEnergie: 1.0)
toyota.description      // Toyota Avensis 2008 avec une jauge de 1.0

// Utilisation de l'Extension pour ajouter un initialiseur
extension Vehicule {
    init(marque: String, modele: String, annee: Int) {
        self.init(marque: marque, modele: modele, annee: annee, jaugeEnergie: 0.5)
    }
}
let peugeot = Vehicule(marque: "Peugeot", modele: "5008", annee: 2010)
toyota.jaugeEnergie                 // 1.0
peugeot.jaugeEnergie        // 0.5


// Utilisation de l'Extension pour intégrer un type imbriqué
extension Vehicule {
    // Type imbriqué dans Vehicule
    enum Epoque {
        case antique, vintage, moderne
    }
    
    var epoque: Epoque {
        switch annee {
        case ...1919:
                return .antique
        case 1920...1930:
                return .vintage
            default :
                return .moderne
        }
    }
}

peugeot.epoque      // moderne

// Utilisation de l'extension pour ajouter des méthodes
extension Vehicule {
    mutating func consommation(de quantite: Double) {
        precondition(quantite >= 0.0 && quantite <= 1.0, "Valeur entre 0 et 1")
        jaugeEnergie -= quantite
    }
    
    mutating func faireLePlein() {
        jaugeEnergie = 1.0
    }
}

var opel =  Vehicule(marque: "Opel", modele: "Insigna", annee: 2014)
opel.jaugeEnergie               // 0.5
opel.consommation(de: 0.3)
opel.jaugeEnergie              // 0.2
opel.faireLePlein()
opel.jaugeEnergie            // 1.0

//============ Les opérteurs personnalisés =============

// Groupes de priorité définis dans Swift pour *, +, et -
precedencegroup AdditionPrecedence {
    associativity: left
    higherThan: RangeFormationPrecedence
}

precedencegroup MultiplicationPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator * : MultiplicationPrecedence
infix operator + : AdditionPrecedence
infix operator - : AdditionPrecedence

precedencegroup DefaultPrecedence {
higherThan: TernaryPrecedence
}

// Définition du groupe de priorité pour notre opérateur de puissance **

precedencegroup PrioriteDePuissance {  // Volontairement, le nom est en français
    higherThan: MultiplicationPrecedence
    associativity: right
}

// Définition de l'opérateur de puissance **
infix operator ** : PrioriteDePuissance


// Implémentation d'une version naïve de l'opérateur **
func **(base: Int, exposant: Int) -> Int {
    if exposant == 0 {
        return 1
    }
    if exposant == 1 {
        return base
    }
    
    var resultat = base
    for _ in 2...exposant {
        resultat *= base
    }
    
    return resultat
}
// Test de notre opeérateur **
let deuxExposant0 = 2 ** 0     // 1
let cinqExposant1 = 5 ** 1     // 5
let neufExposant7 = 9 ** 7     // 4782969

// Définition et implémentation de l'opérateur d'affectation composée **=
infix operator **= : PrioriteDePuissance

func **=(gauche: inout Int, droite: Int) {
    gauche = gauche ** droite
}

// Test de l'opérateur **=

var nombre = 8
nombre **= 2    // 8 Exposant 2 = 64

//Une version générique possible de l'opérateur **
func **<T: Numeric>(base: T, exposant: Int) -> T {
    var resultat = base
    for _ in 2...exposant {
        resultat *= base
    }
    return resultat
}

//Une version générique possible de l'opérateur **=
func **=<T:Numeric>(gauche: inout T, droite: Int) {
    gauche = gauche ** droite
}

let exposantGnenerique = 12.5 ** 7  // 47683715.8203125
var affectionGenerique = 4.9
affectionGenerique **= 9            // 1628413.59791045

let possible = ((2 * 8) ** 5) ** 3       // 1152921504606846976


// Ne peuvent pas compiler en l'état sans les règles de priorité et d'associativité

let avecAutresOperateurs = 2 + 8 * 5 ** 3       // 1002
let aPlusieursReprises = 2 ** 8 * 5 ** 3 * 4    // 128000

var ipo = 2 ** 8
var iip = 5 ** 3
let ap = iip * ipo

// ===== Définition des indices ====



opel["annee"]   // Impossible car la valeur du type Vehicule n'a pas d'indice
opel["modele"] // Impossible car la valeur du type Vehicule n'a pas d'indice

// Ajout d'un indice au type Vehicule
extension Vehicule {
    subscript (key: String) -> String? {
        switch key {
            case "annee":
                return "\(annee)"
            case "modele":
                return modele
            case "marque":
                return marque
            default:
                return nil
        }
    }
}

// Définition d'un indice static
enum DirectionCardinale: Int {
    case nord = 1, sud, est, ouest
    
    static subscript (sens: Int) -> DirectionCardinale {
        return DirectionCardinale(rawValue: sens) ?? .nord
    }
}

let direction = DirectionCardinale[3]   // est

//==== Application de l'attribut @dynamicMemberLookup

// Étape 1: Déclaration de l'attribut
@dynamicMemberLookup
struct Livre {
    let auteur: String
    let annee: Int
    
    // Étape 2: Implémentation de l'indice subscript(dynamicMember:)
    subscript(dynamicMember membre: String) -> String {
        guard auteur == membre  else {
            return "Le livre recherché n'est pas référencé dans notre base"
        }
        return "Le livre dont l'auteur est \(auteur) est paru en \(annee)"
    }
}

let monLivre = Livre(auteur: "Igor", annee: 2021)

//Étape 3: Appel de l'indice avec la notation par point (.)
monLivre.Igor   // "Le livre dont l'auteur est Igor est paru en 2021"

// Étape 3Bis : Appel de l'indice avec la notation par le crochet []
monLivre[dynamicMember: "Igor"]  // "Le livre dont l'auteur est Igor est paru en 2021"

// ==== Les chemins d'accès à l'œuvre
// Exemple de fonctionnement des chemins d'accès KeyPath<Root, Value>
class Tutoriel {
    let titre: String
    let livre: Livre
    let details: (matiere: String, plateforme: String)
    
    init (titre: String, livre: Livre, details:(String, String)) {
        self.titre = titre
        self.livre = livre
        self.details = details
    }
}

let tutoriel = Tutoriel(titre: "Programmation Swift", livre: monLivre, details: ("POP", "iOS"))
let cheminDAccesAuTitre = \Tutoriel.titre                  // KeyPath<Tutoriel, String>
let titreDuTutoriel = tutoriel[keyPath: cheminDAccesAuTitre] // "Programmation Swift"

// Accès aux autres propriétés y compris les tuples
let accesALauteurDuLivreDuTutoriel = \Tutoriel.livre.auteur
let nomDeLAuteurDuLivreDuTutoriel = tutoriel[keyPath: accesALauteurDuLivreDuTutoriel]

let accesALAnneeDuLivreDuTutoriel = \Tutoriel.livre.annee // KeyPath<Tutoriel, Int>
let anneeDuLivreDuTutoriel = tutoriel[keyPath: accesALAnneeDuLivreDuTutoriel]   // 2021

let accesALaMatiereDuTotoriel = \Tutoriel.details.matiere // KeyPath<Tutoriel, String>

// Mutation d'une propriété depuis le chemin d'accès
struct Jukebox {
    var chanson: String
}

var lecteur = Jukebox(chanson: "Les rois du monde")

let accesAChanson = \Jukebox.chanson
lecteur[keyPath: accesAChanson] = "Ne me quitte pas"


// Combinaison de KeyPath<Root, Value> et @dynamicMemberLookup

// Etape 1: Identification ou définition du type Value
struct Point: CustomStringConvertible {
    let x, y: Int
    var description: String {
        "Point(abscisse: \(x), ordonnée: \(y))"
    }
}

// Etatpe 2 : Identification ou définition du type Root
struct Vecteur {
    let pointA, pointB: Point
}

// Etape 3: Définition du type qui autorise la recherche dynamique
@dynamicMemberLookup
struct Cercle {
    let vecteurDuDiametre: Vecteur
    let centre : Point
    
    // Etape 4: Implémentation de l'indication avec le chemin d'accès
    subscript(dynamicMember chemin: KeyPath<Vecteur, Point>) -> Point {
        vecteurDuDiametre[keyPath: chemin]
    }
}

// Préparatifs
let pointA = Point(x: 3, y: 5)
let pointB = Point(x: 8, y: 2)
let centre = Point(x: (pointA.x + pointB.x)/2, y: (pointA.y + pointB.y)/2)
let vecteurDuDiametre = Vecteur(pointA: pointA, pointB: pointB)

// Création d'un cercle à partir duquel on va dynamiquement appeler
// les propriétés de vecteurDuDiametre dont le type est Vecteur
let cercle = Cercle(vecteurDuDiametre: vecteurDuDiametre, centre: centre)

// Étape 5 : Appel dynamique des propriétés de Vecteur
cercle.pointA
cercle.pointB

