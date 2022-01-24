//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 20. Comment prévenir les fuites de mémoire dans vos programmes ?
//======================================================================================

// La classe Livre complétée
class Livre {
    let titre: String
    unowned let auteur: Auteur
    // Anticipation relative au phénomène du cycle de référence
    weak var editeur: Editeur?
    
    init(titre: String, auteur: Auteur) {
        self.titre = titre
        self.auteur = auteur
    }
    
    deinit {
        print("Disparition de l'ouvrage : \(titre)")
    }
    
    // Propriété de calcul de la description sous forme de closure
    lazy var description : () -> String = {
        "Le livre : \(self.titre) est écrit par \(self.auteur.nom)"
    }
    
    // Propriété de calcul de la description sous forme de closure à référence sans propriétáire
    lazy var descriptionSansProprietaire : () -> String = {
        [unowned self] in
        "Le livre : \(self.titre) est écrit par \(self.auteur.nom)"
    }
    
    // Propriété de calcul de la description sous forme de closure avec référence faible
    lazy var descriptionAvecReferenceFaible : () -> String = {
        [weak self] in
        guard let instance = self
        else { return "Cette instance de livre n'existe plus"  }
        return "Le livre : \(instance.titre) est écrit par \(instance.auteur.nom)"
    }
}

// La classe Editeur
class Editeur {
    let nom: String
    var publications: [Livre] = []
    
    init(nom: String) {
        self.nom = nom
    }
    
    deinit {
        print("Fin de l'aventure pour l'éditeur : \(nom)")
    }
}



// Définition de la classe Auteur
class Auteur {
    let nom: String
    var livres: [Livre] = []
    init (nom: String) {
        self.nom =  nom
    }
    
    deinit {
        print("À bientôt cher auteur : \(nom) !")
    }
}

// Mise en évidence du phénomène du cycle de référence

do {
    let auteur = Auteur(nom: "Igor")
    let livre = Livre(titre: "Gestion de la fuite de mémoire", auteur: auteur)
    //Création d'un cycle de référence entre Livre et la closure descriptionSansReferenceProprietaire
    print(livre.descriptionAvecReferenceFaible())
    let editeur = Editeur(nom: "Cristalswift")
    livre.editeur = editeur
    editeur.publications.append(livre)
    auteur.livres.append(livre)
}

// Illustration de la technique d'échappement des clousures
final class GestionDeCloure {
    private let closure: () -> Void          // 1
    init(closure: @escaping () -> Void) {   // 2
        self.closure = closure
    }
    
    func execute() {                   // 3
        closure()
    }
}

// Utilisation de la classe GestiondeClosure
let nom = "Igor"
let cloture = GestionDeCloure {
    print("Bonjour, \(nom)")
}
cloture.execute()   // Bonjour, Igor

// Code sans liste de capture
var compteur = 0
var closureSansListeDeCapture = { print(compteur)}
compteur = 4
closureSansListeDeCapture()     // 4

//Avec liste de capture
var capture = 0
var closureAvecListeDeCapture = { [c = capture] in print(c)}
capture = 6
closureAvecListeDeCapture()     // 0
