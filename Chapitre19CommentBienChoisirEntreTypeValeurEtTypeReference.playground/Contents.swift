//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 19. Comment bien choisir entre les types à valeur et le types à référence ?
//======================================================================================

//Définition d'une structure Couleur
struct Couleur: CustomStringConvertible {
    var rouge, bleu, vert: Double
    
    var description: String {
        "Couleur = { R : \(rouge), V : \(vert) B : \(bleu) }"
    }
}

//Fabrication des couleurs primaires
extension Couleur {
    static var noir = Couleur(rouge: 0, bleu: 0, vert: 0)
    static var blanc = Couleur(rouge: 1, bleu: 1, vert: 1)
    static var rouge = Couleur(rouge: 1, bleu: 0, vert: 0)
    static var bleu = Couleur(rouge: 0, bleu: 1, vert: 0)
    static var vert = Couleur(rouge: 0, bleu: 0, vert: 1)
}

// Définition de la classe Peinture, un type à référence
class Peinture {
    var coloris: Couleur
    var estDejaVendu = false
    init(coloris: Couleur){
        self.coloris = coloris
    }
    func vendre() {
        estDejaVendu = true
    }
}
// Comportement du type à référence

let bleuCiel = Peinture(coloris: .bleu)     // Choix de la première personne
bleuCiel.estDejaVendu       // false ==> initialement NON
let bleuRoi = bleuCiel                      // Choix de la seconde personne.
bleuCiel.vendre()                           // À la première personne
// Vérifions si BleuRoi est aussi vendu
bleuRoi.estDejaVendu       // true, pas surprenant

// Définition de la structure PeintureValeur, un type à valeur
struct PeintureValeur {
    var coloris: Couleur
    var estDejaVendu = false
    init(coloris: Couleur){
        self.coloris = coloris
    }
    mutating func vendre() {
        estDejaVendu = true
    }
}

var ColorisBleuciel = PeintureValeur(coloris: .bleu)    // Choix de la première personne
ColorisBleuciel.estDejaVendu                           // false ==> initialement NON
var colorisBleuRoi = ColorisBleuciel                  // Choix de la seconde personne.
colorisBleuRoi.vendre()                              // À la première personne

// Vérifions si colorisBleuCiel est aussi vendu
ColorisBleuciel.estDejaVendu                        // false

//=============== Implémentation de la sémantique de valeur ==============================
// Illustration du cas n°4
struct Fourniture {
    // Un type à valeur contenant ...
    // un type à valeur
    var ton = Couleur.blanc
    // et un type à référence
    var peinture = Peinture(coloris: .bleu)
}

// Fourniture pour la table
let fournitureDeTable = Fourniture()
// Fourniture pour la chaise par copie de celle de la table pour modification
let forunitureDeChaise = fournitureDeTable
//Quel est le coloris de la peinture de fournitureDeTable ?
fournitureDeTable.peinture.coloris   // Couleur = { R : 0.0, V : 0.0 B : 1.0 }
//Changement du coloris de la peinture de fournitureDeChaise en vert.
forunitureDeChaise.peinture.coloris = Couleur.vert
//Le coloris de la peinture de fournitureDeTable est-il toujours bleu ?
fournitureDeTable.peinture.coloris  // Couleur = { R : 0.0, V : 1.0 B : 0.0 }, problème...


// Recours à la technique "copie-on-Write" => copie-sur-écriture
struct FournitureCSE {
    // Un type à valeur contenant ...
    // un type à valeur
    var ton = Couleur.blanc
    // et un type à référence en acces privé pour une copie en profondeur
    private var peinture = Peinture(coloris: .blanc)
    // définition des propriétés nécessaires à la copie en profondeur
    var colorisDePeinture: Couleur {
        get { peinture.coloris }
        set {   // Mise en place de l'optimisation via le contrôle d'unicité
            if isKnownUniquelyReferenced(&peinture) {
                peinture.coloris = colorisDePeinture
            } else {
                peinture = Peinture(coloris: newValue)
            }
        }
    }
}
