//====================================================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 16. Comment se servir des enveloppes ou capsules de propriétés ainsi que des générateurs de résultats ?
//===================================================================================================================
 

// Introduction aux enveloppes de propriétés
struct IntervalleUnitaire {
    private var valeurHaute : Double = 1.0
    public var jauge: Double {
        get {
            valeurHaute
        }
        set {
            valeurHaute = min(max(newValue, 0), 1)
        }
    }
}

var maValeur = IntervalleUnitaire()
maValeur.jauge = 12
print(maValeur.jauge)
maValeur.jauge = -3
print(maValeur.jauge)


// Structure de stockage des informations relatives aux valeurs projetées de wrappedValue
struct Information: CustomStringConvertible {
    var valeurDeBase: Double
    var indication: Bool
    public var description: String {
        return "Valeur de base = \(self.valeurDeBase) et indication = \(self.indication) "
    }
}

// Implémentation de l'enveloppe de propriété Jauge
@propertyWrapper
struct Jauge {
    
    private var capsule: Double
    private var infos: Information
    
    public init(wrappedValue valeurEncapsulee: Double) {
        infos = Information(valeurDeBase: valeurEncapsulee, indication: false)
        capsule = min(max(valeurEncapsulee, 0), 1)
    }
    
    public var wrappedValue: Double {
        set {  capsule = min(max(newValue, 0), 1) }
        get { capsule }
    }
    
    // Valeur projetée
    public var projectedValue: Information {
        mutating get {
                        infos.indication = (0...1).contains(wrappedValue)
                        return infos
        }
    }
}


struct Vehicule {
    @Jauge var carburant: Double
    @Jauge var liquideDeRefroidissement: Double
}

var maVoiture = Vehicule(carburant: 4.6, liquideDeRefroidissement: 0.98)
print(maVoiture.carburant)
print(maVoiture.liquideDeRefroidissement)

// Accession directe à l'enveloppe d'une propriété
extension Vehicule : CustomStringConvertible {
    var description: String {
        return "Le niveau de carburant est : \(carburant), enveloppé par \(_carburant)"
    }
}

print(maVoiture) // Le niveau de carburant est : 1.0, enveloppé par Jauge(capsule: 1.0)

print("La valeur projetée de carburant (\(maVoiture.carburant)) est composée de : \(maVoiture.$carburant)")
print("La valeur projetée de liquideDeRefroidissemsnt est : \(maVoiture.$liquideDeRefroidissement)")


// Version générique de Jauge
@propertyWrapper
struct JaugeGenerique<T: Comparable> {
    var capsule: T
    let intervalle: ClosedRange<T>
    
    init(wrappedValue valeurEnveloppee: T, _ plageDeValeur: ClosedRange<T>) {
        precondition(plageDeValeur.contains(valeurEnveloppee), "Votre valeur est invalide !")
        self.capsule = valeurEnveloppee
        self.intervalle = plageDeValeur
    }
    
    var wrappedValue: T {
        get { capsule }
        set {
            capsule = min(max(intervalle.lowerBound, newValue), intervalle.upperBound)
        }
    }
}

// Exemples d'utilisation de JaugeGenerique
struct JaugeFloat{
    
    @JaugeGenerique(0.00...7.10) var pH: Float = 0.00
}

struct JaugeInt {
    @JaugeGenerique(wrappedValue: 5, 1...100) var jaugeEntiere
}

var jaugeFloat = JaugeFloat()
jaugeFloat.pH = 15.0
print(jaugeFloat.pH)

var jaugeInt = JaugeInt()
jaugeInt.jaugeEntiere = 150
print(jaugeInt.jaugeEntiere)

//====== Exemple pour cerner l'intérêt de recourir au générateur de résultat ===

// Données de paramétrage d'une application

struct Parametre {
    var nom: String
    var valeur: Parametrage
    
    enum Parametrage {
        case booleen (Bool)
        case numerique (Int)
        case textuel(String)
        case groupal([Parametre])
    }
}
// Une configuration possible des paramètres de notre application hypothétique

let parametres = [
    Parametre(nom: "Mode de connexion", valeur: .booleen(false)),
    Parametre(nom: "Pagination", valeur: .numerique(12)),
    Parametre(nom: "Expérimental", valeur: .groupal([
        Parametre(nom: "Nom par défaut", valeur: .textuel("Inconnu")),
        Parametre(nom: "animation", valeur: .booleen(true))
    ]))
]


// Un détour par SwiftUI
import SwiftUI

let pileDeVues = VStack {
    Text("Bonjour")
    Text("les générateurs de résultats !")
    Button("Je suis un bouton !") { }
}

print(type(of: pileDeVues))
// VStack<TupleView<(Text, Text, Button<Text>)>>

// Générateur de paramètres pour illustrer l'implémentation des @resultBuilder

@resultBuilder
struct ParametreBuilder {
    static func buildBlock() -> [Parametre] {
        []
    }
}

func genererDesParametres(@ParametreBuilder _ contenu: () -> [Parametre]) -> [Parametre] {
    contenu()
}

let mesParametres = genererDesParametres {}
print(type(of: mesParametres))  // Array<Parametre>

extension ParametreBuilder {
    static func buildBlock(_ parametres: Parametre...) -> [Parametre] {
        parametres
    }
}

let parametresGeneres = genererDesParametres {
    
    Parametre(nom: "Mode de connexion", valeur: .booleen(false))
    Parametre(nom: "Pagination", valeur: .numerique(12))
    
    Parametre(nom: "Expérimental", valeur: .groupal([
        Parametre(nom: "Nom par défaut", valeur: .textuel("Inconnu")),
        Parametre(nom: "Animation", valeur: .booleen(true))
    ]))
}

//Définition d'un type pour générer des groupes de paramètres

//struct GroupeDeParametres {
//    var nom: String
//    @ParametreBuilder var groupe: () -> [Parametre]
//}

//Définition d'un type pour générer des groupes de paramètres: nouvelle approche

struct GroupeDeParametres {
    var nom: String
    var groupe: [Parametre]
    
    init(nom: String, @ParametreBuilder generateur: () -> [Parametre]) {
        self.nom = nom
        self.groupe = generateur()
    }
}

let groupeDeParametres = GroupeDeParametres(nom: "Expérimental") {
    Parametre(nom: "Nom par défaut", valeur: .textuel("Inconnu"))
    Parametre(nom: "Animation", valeur: .booleen(true))
}

// Tester l'appel de genererDesParametres avce groupeDeParametres
//let parametresGeneresBis = genererDesParametres {
//    Parametre(nom: "Mode de connxion", valeur: .booleen(false))
//    Parametre(nom: "Pagination", valeur: .numerique(12))
//    groupeDeParametres  // Erreur : Ne peut pas convertir GroupeDeParametres en Parametre
//}

// Définition et application du protocole ParametreConvertible

protocol ParametreConvertible {
    func enParametres() -> [Parametre]
}

extension Parametre: ParametreConvertible {
    func enParametres() -> [Parametre] { [self] }
}

extension GroupeDeParametres: ParametreConvertible {
    func enParametres() -> [Parametre] {
        [Parametre(nom: nom, valeur: .groupal(groupe))]
    }
}

extension ParametreBuilder {
    static func buildBlock(_ parametres: ParametreConvertible...) -> [Parametre] {
        parametres.flatMap { $0.enParametres() }
    }
}


 //Tester l'appel de genererDesParametres avce groupeDeParametres
let parametresGeneresBis = genererDesParametres {
    Parametre(nom: "Mode de connexion", valeur: .booleen(false))
    Parametre(nom: "Pagination", valeur: .numerique(12))
    groupeDeParametres  // Cela fonctionne maintenant !!!
}

// Les instructions conditionnelles ne fonctionnent pas par défaut
// pour les générateurs de résultats. Il faut les implémenter !

let conditionDExperimentation : Bool = true
//
//let parametresConditionnels = genererDesParametres {
//    Parametre(nom: "Mode de connexion", valeur: .booleen(false))
//    Parametre(nom: "Pagination", valeur: .numerique(12))
//    //Erreur : La clôture contenant l'instruction de flux de contrôle ne peut pas
//    //         être utilisée avec le générateur de résultats 'ParametreBuilder'
//    if conditionDExperimentation {
//    groupeDeParametres
//    }
//
//}

// Adoption du protocole ParametreConvertible par Array afin de rendre possible
// le renvoi d'un tableau vide dont Parametre serait le type des éléments.
extension Array: ParametreConvertible where Element == Parametre {
    func enParametres() -> [Parametre] { self }
}

// Implémentation de la prise en charge de l'instruction if
extension ParametreBuilder {
    static func buildOptional(_ parametres: ParametreConvertible?) -> ParametreConvertible {
        parametres ?? []
    }
}

// Implémentation de la prise en charge des instructions if...else et switch
extension ParametreBuilder {
    static func buildEither(first resultatEval: ParametreConvertible) -> ParametreConvertible {
        resultatEval
    }
    
    static func buildEither(second resultatEval: ParametreConvertible) -> ParametreConvertible {
        resultatEval
    }
}

let parametresConditionnels = genererDesParametres {
    Parametre(nom: "Mode de connexion", valeur: .booleen(false))
    Parametre(nom: "Pagination", valeur: .numerique(12))
    
    if conditionDExperimentation {
    groupeDeParametres
    }
    else {
        Parametre(nom: "Permission pour un accès expérimental", valeur: .booleen(false))
    }

}

// Définition de quelques niveaux d'accès utilisateur
enum Privilege {
    case restreint
    case normal
    case experimental
}

let privilegeUtilisateur: Privilege = .normal

//Test de la priche en compte des selections switch
let parametresSelectifs = genererDesParametres {
    Parametre(nom: "Mode de connexion", valeur: .booleen(false))
    Parametre(nom: "Pagination", valeur: .numerique(12))
    
    switch privilegeUtilisateur {
        case .restreint:
            Parametre(nom: "Mode restreint", valeur: .numerique(0))
        case .normal:
            Parametre(nom: "Mode normal", valeur: .booleen(true))
        case .experimental:
            groupeDeParametres
    }
}

// Architecture modèle d'un type générateur de résultats

@resultBuilder
struct ConstructeurDeResultat {
    
    typealias Expression = ...
    typealias Component = ...
    typealias FinalResult = ...
    
    static func buildBlock(_ components: Component...) -> Component { ... }
    
    static func buildOptional(_ component: Component?) -> Component { ... }
    
    static func buildEither(first: Component) -> Component { ... }
    
    static func buildEither(second: Component) -> Component { ... }
    
    static func buildArray(_ components: [Component]) -> Component { ... }
    
    static func buildExpression(_ expression: Expression) -> Component { ... }
    
    static func buildFinalResult(_ component: Component) -> FinalResult { ... }
    
    static func buildLimitedAvailability(_ component: Component) -> Component { ... }
}

