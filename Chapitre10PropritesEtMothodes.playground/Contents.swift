//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 10. Comment enrichir vos types grâce aux propriétés et aux méthodes ?
//========================================================================================

//===== Les propriétés stockées =====================
import SwiftUI
// Modélisation du type Triangle comme une structure ou une classe

// Définition du type Triangle comme une structure
struct TriangleStructure {
    var couleur = Color.orange
    var contour = Color.black
    let nombreDeCotes = 3
}

// Utilisation d'une instance de TriangleStructure
let unTriangle = TriangleStructure()
print(unTriangle)

// Définition du type Triangle comme une classe
class TriangleClasse {
    var couleur = Color.orange
    var contour = Color.black
    let nombreDeCotes = 3
    init() {
        self.couleur = Color.orange
        self.contour = Color.black
    }
}
// Utilisation d'une instance de TriangleClasse
let autreTriangle = TriangleClasse()
print("TriangleClasse : couleur = \(autreTriangle.couleur), contour = \(autreTriangle.contour), \(autreTriangle.nombreDeCotes) côtés")

// Définition du type Triangle
struct Triangle {
    // Attachement des observateurs à la propriété couleur
    var couleur: Color = Color.orange {
        willSet(nouvelleCouleur) {
            print("Attention, la couleur va passer de \(couleur) à \(nouvelleCouleur)")
        }
        didSet(ancienneCouleur) {
            print("Et voilà, la couleur est passée de \(ancienneCouleur) à \(couleur)")
        }
    }
    var contour = Color.black {
        willSet {
            print("Le contour va changer de couleur en passant du \(contour) au \(newValue)")
        }
        didSet {
            print("Le contour est passé du \(oldValue) au \(contour)")
        }
    }
    let nombreDeCotes: Int
    
    mutating func changerLesCouleurs(remplissage teinte: Color, contour coloris: Color) {
        couleur = teinte
        contour = coloris
    }
    // Définition à insérer à la fin, avant l'accolade fermante de struct Triangle
    static func jeMePresente() {
        print("Je modélise une figure géométrique à 3 cotés")
    }
}


// utilisation d'une instance de Triangle
let triangle = Triangle(couleur: Color.orange, contour: Color.black, nombreDeCotes: 3)
print(triangle)
print("triangle a pour propriétés: coulour = \(triangle.couleur), contour = \(triangle.contour) et \(triangle.nombreDeCotes) côtés")

//Tentatives de modification de la propriété var couleur
    // Erreur ! Car unTriangle est une structure constante
//unTriangle.contour = Color.yellow

    // Ça passe ! Car autreTriangle est une classe, bien que constante.
autreTriangle.couleur = Color.yellow
print("Nouvelle couleur de autreTriangle: \(autreTriangle.couleur)")

// Mise en œuvre des observateurs de propriété
var triangleEnObservation = Triangle(nombreDeCotes: 3)

// Changement de la couleur
triangleEnObservation.couleur = Color.green
triangleEnObservation.contour = Color.gray

// Définition du type Cercle avec quelques propriétés
struct Cercle {
    // Propriété stockée à initialiser à la création d'une instance de Cercle
    var rayon: Double
    
   // Propriété calculée en fonction de rayon en lecture-écriture
    var diametre: Double {
        get {
            rayon * 2
        }
        set {
            rayon = newValue / 2
        }
    }
    // Propriété stockée π en état de paresse
    lazy var π: Double = {
        4.0 * (4 * atan(1.0 / 5.0) - atan(1.0 / 239.0))
    }()
    // Propriété calculée en lecture-seule
    var circonference: Double {
        mutating get {
        diametre * π
        }
    }
}

// Utilisation d'une instance de Cercle
var cercle = Cercle(rayon: 3.5)
print("Le diamètre du cercle doit être : \(cercle.diametre)")
// Modification du diamètre à 12
cercle.diametre = 12
// Le rayon devient
print("La nouvelle valeur du rayon est : \(cercle.rayon)")

// Comparons notre valeur de π à celle fournie par Apple
print("La valeur de pi fourni par Apple est : \(Double.pi)")
print("Notre valeur de π est :                \(cercle.π)")

// Définition de Triangle avec une propriété de type
struct Triangle2 {
    // Autre code
    
    // Proriété statique
    static let nombreDeCotes = 3
}

// Appel de la propriété statique
print("La propriété statique a pour valeur : \(Triangle2.nombreDeCotes)")

// Le mot-clé mutating n'est pas requis pour les classes

class Carre {
    // Attachement des observateurs à la propriété couleur
    var couleur: Color = Color.orange {
        willSet(nouvelleCouleur) {
            print("Attention, la couleur va passer de \(couleur) à \(nouvelleCouleur)")
        }
        didSet(ancienneCouleur) {
            print("Et voilà, la couleur est passée de \(ancienneCouleur) à \(couleur)")
        }
    }
    var contour = Color.black {
        willSet {
            print("Le contour va changer de couleur en passant du \(contour) au \(newValue)")
        }
        didSet {
            print("Le contour est passé du \(oldValue) au \(contour)")
        }
    }
    let nombreDeCotes: Int
    
    static var propriete: Double {
        Double.pi
    }
    
    init() {
        nombreDeCotes = 4
    }
    
    func changerLesCouleurs(remplissage teinte: Color, contour coloris: Color) {
        couleur = teinte
        contour = coloris
    }
    
    func changerLesCouleurs(remplissage couleur: Color, bordure contour: Color) {
        self.couleur = couleur
        self.contour = contour
    }
    
    // Définition à insérer à la fin avant l'accolade fermante de class Carre
    class func jeMePresente() {
        print("Je modélise une figure géométrique à 4 cotés")
    }
}

// Appel des méthodes de type sur Triangle et Carre
Triangle.jeMePresente()
Carre.jeMePresente()
Carre.propriete

//Définition de deux calculs mathématiques sans rapport avec une instance de type
struct Math {
    //Table de multiplication de 1 à 12 ou au delà pour un nombre quelconque
    static func tableDeMultiplication(de nombre: Int, limite : Int = 12) -> [Int] {
        //Condition à surveiller : limite ≥ 12
        guard limite >= 12 else {
            print("Merci d'indiquer une limite supérieure à 12.")
            return [nombre]
        }
        var table = [Int]()
        for i in 1...limite { table.append(nombre * i) }
        return table
    }
    
    // Calcul de la factorielle d'un nombre entier quelconque
    static func factorielle(de nombre: Int) -> Int {
        (1...nombre).reduce(1, *)
    }
}
//Appel des méthodes de type
let tableDe9 = Math.tableDeMultiplication(de: 9)
let factorielleDe9 = Math.factorielle(de: 9)
print(tableDe9)
print(factorielleDe9)



