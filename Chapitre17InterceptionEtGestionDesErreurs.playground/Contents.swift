//==================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 17. Comment intercepter et gérer vos erreurs de codage en Swift ?
//==================================================================================


// Le premier niveau de prise en charge des erreurs
let valeur = Int("3)")              // Optional(3)
let erreurValeur = Int("entier")    // nil

// Gestion des stocks de friandises par une petite boulangerie
struct Friandise {
    let parfum: String
    var stock: Int
}

// Modélisation de quelques désagréments possibles comme des erreurs
enum ErreurDuDebutant: Error {
    case quantite(stock: Int)
    case articleEnRupture
    case mauvaisParfum
    case inventaire
    case enPanne
}

class Patisserie {
    var produitsEnVente = [
        "Cookies": Friandise(parfum: "Noisette", stock: 20),
        "Caline": Friandise(parfum: "Chocolat", stock: 50),
        "Croissant": Friandise(parfum: "Amande", stock: 13),
        "Boule": Friandise(parfum: "Fraise", stock: 24),
        "Beignet": Friandise(parfum: "Pomme", stock: 6)
    ]
    
    func ouvrir(_ maintenant: Bool = Bool.random()) throws {
        guard maintenant
        else {
            throw Bool.random() ? ErreurDuDebutant.inventaire : ErreurDuDebutant.enPanne
        }
    }
    
    func prendreCommande(article: String, parfum: String, quantite: Int) throws -> Friandise {
        guard var friandise = produitsEnVente[article]  // S'assure que l'artice existe
        else {
            throw ErreurDuDebutant.articleEnRupture     // Sinon, déclence une erreur
        }
        guard parfum == friandise.parfum               // S'assure que le parfum existe
        else {
            throw ErreurDuDebutant.mauvaisParfum       // Sinon, déclenche une erreur
        }
        guard quantite <= friandise.stock              // S'assure de la quantité en stock
        else {
            throw ErreurDuDebutant.quantite(stock: friandise.stock)
        }
        produitsEnVente[article]?.stock -= quantite     // Met à jour le stock
        friandise.stock = quantite
        
        return friandise
    }
}

let maPatisserie = Patisserie()
try maPatisserie.ouvrir()
let maCommande = try maPatisserie.prendreCommande(article: "Caline", parfum: "Chocolat", quantite: 30)
print(maCommande)   // Friandise(parfum: "Chocolat", stock: 30)




let commande: Friandise

do {
    try maPatisserie.ouvrir()
    commande = try maPatisserie.prendreCommande(article: "Caline", parfum: "Chocolat", quantite: 30)
} catch ErreurDuDebutant.inventaire, ErreurDuDebutant.enPanne {
    print("Désolé, nous sommes fermes  en ce moment !")
} catch ErreurDuDebutant.articleEnRupture {
    print("Désolé, nous sommes en rupture de stock pour cet article !")
} catch ErreurDuDebutant.mauvaisParfum {
    print("Désolé, nous n'avons plus ce parfum !")
} catch ErreurDuDebutant.quantite {
    print("Désolé, tout est déjà vendu !" )
}

//Comment arrêter le programme suite à une erreur
do {
    try maPatisserie.ouvrir(true)
    try maPatisserie.prendreCommande(article: "Boule", parfum: "Fraise", quantite: 5)
}
catch {
    fatalError("Je suis trop sûr de moi !")
}

try! maPatisserie.ouvrir(true)
let uneCommande = try! maPatisserie.prendreCommande(article: "Boule", parfum: "Fraise", quantite: 2)


// La gestion des erreurs de déplacement du véhicule
enum Direction {
    case gauche, droite, avance
}

enum ErreurOrientation: Error {
    case mauvaiseTrajectoire(suivie: Direction, correcte: Direction)
    case sansIssue
}

class Vehicule {
    let nom: String
    let itineraire: [Direction]
    
    private var etapeDansItineraire = 0
    
    init(nom: String, itineraire aSuivre: [Direction]) {
        self.nom = nom
        self.itineraire = aSuivre
    }
    
    func avance(_ direction: Direction) throws {
        guard etapeDansItineraire < itineraire.count
        else {
            throw ErreurOrientation.sansIssue
        }
        let directionSuivante = itineraire[etapeDansItineraire]
        guard directionSuivante == direction
        else {
            throw ErreurOrientation.mauvaiseTrajectoire(suivie: direction, correcte: directionSuivante)
        }
        etapeDansItineraire += 1
    }
    
    func garage() {
        etapeDansItineraire = 0
    }
}
let monItineraire: [Direction] = [.avance, .droite, .droite, .gauche, .avance]
let monVehicule = Vehicule(nom: "Jouet", itineraire: monItineraire)

func promenade() throws {
    for dir in monItineraire {
        try monVehicule.avance(dir)
    }
}
do {
    try promenade()
} catch {
    print("La promenande n'a pas été concluante !")
}


func seDeplacerEnSecurite(_ conduire: () throws -> ()) -> String {
    do {
        try conduire()
        return "Déplacement réussi avec succès !"
    } catch ErreurOrientation.mauvaiseTrajectoire(let suivie, let correcte) {
        return "La bonne direction est \(correcte) et non \(suivie),"
    } catch ErreurOrientation.sansIssue {
        return "Le jouet s'engage dans une direction sans issue"
    }catch {
        return "Erreur inconnue !"
    }
}

monVehicule.garage()
seDeplacerEnSecurite {
    try monVehicule.avance(.avance)
    try monVehicule.avance(.droite)
    try monVehicule.avance(.droite)
    try monVehicule.avance(.gauche)
    try monVehicule.avance(.avance)
}

func relanceurDErreur(mouvement: (_ dir: Direction) throws -> ()) rethrows {
    for dir in monItineraire {
        try mouvement(dir)
    }
}

// Lancement d'erreur depuis une propriété calculée


struct Personne {
    var nom: String
    var age : Int
}

enum ErreurDePersonne: Error {
    case sansNom, sansAge, sansDonnee
}

extension Personne {
    var donnees: String {
        get throws {
            guard !nom.isEmpty
            else { throw ErreurDePersonne.sansNom }
            guard age > 0
            else { throw ErreurDePersonne.sansAge }
            return "Cette personne s'appelle \(nom) et a \(age) ans."
        }
    }
}

var monVoisin = Personne(nom: "Luc", age: 38)

// Cas n°1
monVoisin.nom = ""
do {
    try monVoisin.donnees
} catch { print(error) }     // sansNom

// Cas n°2
monVoisin.age = -20
do {
    try monVoisin.donnees
} catch { print(error) }    // sansNom

// cas n°3
monVoisin.nom = "Yoann"
do {
    try monVoisin.donnees
} catch { print(error)}     //sansAge

// Tout va bien maintenant !
monVoisin.age = 45

do {
    try monVoisin.donnees   // Cette personne s'appelle Yoann et à 45 ans.
} catch { print(error)}

// Lancement d'une erreur depuis un indice
extension Personne {
    subscript(cle: String) -> String {
        get throws {
            switch cle {
                case "nom": return nom
                case "age": return "\(age)"
                default: throw ErreurDePersonne.sansDonnee
            }
        }
    }
}

// Test du lancement d'erreur par l'indice d u type Personne
do {
    try monVoisin["nom"]    // Yoann
} catch { print(error)}

do {
    try monVoisin["age"]    // 45
} catch { print(error)}

do {
    try monVoisin["homme"]
} catch { print(error)}     // sansDonnee

// Exemple d'adoption du protocole Error par une structure
struct ErreurDeCodage: Error {
    enum NatureDeErreur {
        case caratereInvalide
        case erreurSysteme
        case infoManquante
    }
    
    let ligne: Int
    let colonne: Int
    let nature: NatureDeErreur
}

// Exemple de la fonction de compilation du code
func compile(_ source: String) throws -> String {
    
    // Définition des conditions requises.
    // si conditions non remplies
    throw ErreurDeCodage(ligne: 563, colonne: 2, nature: .infoManquante)
    
    // suite de l'implémentation
    
}

// Test de la fonction compile(:)
do {
    try compile("Code source")
} catch let erreur as ErreurDeCodage {
    print("Erreur de compilation : \(erreur.nature) [\(erreur.ligne) : \(erreur.colonne)] ")
} catch {
    print("Autre erreur non identifiée : \(error)")
}
