//==================================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 12. Comment affiner la conception de vos types: Héritage, abstraction et spécialisation ?
//====================================================================================================
   

// Exemples de marquage du niveau d'accès aux entités
// open
open class ClasseOuverte {
    //...
    public var prenom = "Igor"
}

// public
public class ClassePublique {
    //...
    internal var nom = "AGBOSSOU"
}
public struct StruturePublique {
    //...
    private var salaire = 0.00
    public func nomComplet() -> String {
        "Igor AGBOSSOU"
    }
    mutating private func augmenterSalaire(de montant: Double) {
        salaire += montant
    }
}

// Mise en œuvre de la notion d'héritage avec l'exemple de la figure 12.1

// Définition du type Point comme struct
struct Point {
   var abscisse: Double
   var ordonnee: Double
}

// Définition du type Couleur comme enum
public enum Couleur {
    case bleu, vert, rouge, jaune, orange, magenta
}

// Définition de la super classe Forme
open class Forme {
    public var remplissage: Couleur
    public var contour: Couleur
    
    var description: String {
        return "Je suis une forme de type \(type(of: self)) "
    }
    
    public init(remplissage: Couleur, contour: Couleur) {
        self.remplissage = remplissage
        self.contour = contour
    }
    
    public func perimetre() -> Double { return 0.0 }
    
    public func surface() -> Double { return 0.0 }
}


    
// Définition de la classe Triangle
public class Triangle: Forme {
    var sommet: Point
    var longueurCoteA: Double
    var longueurCoteB: Double
    var longueurCoteC: Double
    
    // Implémentation de l'initialiseur de Triangle
    init(sommet: Point, coteA: Double, coteB: Double, coteC: Double) {
        self.sommet = sommet
        self.longueurCoteA = coteA
        self.longueurCoteB = coteB
        self.longueurCoteC = coteC
        super.init(remplissage: .bleu, contour: .rouge)
    }
    
    override public func perimetre() -> Double {
        longueurCoteA + longueurCoteB + longueurCoteC
    }
}

let unTriangle = Triangle(sommet: Point(abscisse: 12, ordonnee: 6), coteA: 2.5, coteB: 4.7, coteC: 9.3)
let uneForme = Forme(remplissage: .rouge, contour: .jaune)
print(unTriangle.description) // Je suis une forme de type Triangle
print(uneForme.description)   // Je suis une forme de type Forme



// Définition de la classe TriangleIsocele
class TriangleIsocele: Triangle {
   
    init(sommet: Point, longueurCotes: Double, longueurBase: Double) {
        super.init(sommet: sommet, coteA: longueurCotes, coteB: longueurCotes, coteC: longueurBase)
    }
    
    // Exemple de redéfinition de la propriété calculée description dans TriangleIsocele
    override var description: String {
        return  """
                "Je suis un triangle isocèle de type \(type(of: self))"
                " Mes dimensions sont : côtés = \(self.longueurCoteA), base = \(self.longueurCoteC)"
                """
    }
}

// Définition de la classe TriangleEquilateral
class TriangleEquilateral: TriangleIsocele {
    
    init(sommet: Point, longueurCote: Double) {
        super.init(sommet: sommet, longueurCotes: longueurCote, longueurBase: longueurCote)
    }
    override func surface() -> Double {
        let racineDe3 = Double.squareRoot(3)
        return (longueurCoteC * longueurCoteC) * racineDe3() / 4
    }
}

var test = TriangleEquilateral(sommet: Point(abscisse: 5.5, ordonnee: 5.5), longueurCote: 7.0)
print(test.surface())
print(test.perimetre())
print(test.description)

// Test de l'exécution de la redéfinition de propriété description
let triangeIsocele = TriangleIsocele(sommet: Point(abscisse: 12, ordonnee: 12), longueurCotes: 16, longueurBase: 14)
print(triangeIsocele.description)

// Définition de la classe Rectangle
class Rectangle: Forme {
    var centre: Point
    var longueur: Double
    var largeur: Double
    
    init(centre: Point, long: Double, larg: Double, remplissage: Couleur, contour: Couleur) {
        self.centre = centre
        self.longueur = long
        self.largeur = larg
        super.init(remplissage: remplissage, contour: contour)
    }
    override func perimetre() -> Double {
        (longueur + largeur) * 2
    }
    
    override func surface() -> Double {
        longueur * largeur
    }
}

    // Définition de la classe Carre
class Carre: Rectangle {
    init(centre: Point, cote: Double, remplissage: Couleur, contour: Couleur) {
        super.init(centre: centre, long: cote, larg: cote, remplissage: remplissage, contour: contour)
    }
}

    // Définition de la classe Ellipse
class Ellipse: Forme {
    var centre: Point
    var petitAxe: Double
    var grandRAxe: Double
    
    init(centre: Point, petitAxe: Double, grandRAxe: Double, remplissage: Couleur, contour: Couleur) {
        self.centre = centre
        self.petitAxe = petitAxe
        self.grandRAxe = grandRAxe
        super.init(remplissage: remplissage, contour: contour)
    }
    
    // Le périmètre approximatif d'une ellipse
    ///Retourne  2∏* √((grandAxe * grandAxe + petitAxe * petitAxe) / 2)
    override func perimetre() -> Double {
        2 * Double.pi * (((petitAxe * petitAxe + grandRAxe * grandRAxe)/2).squareRoot())
    }
    
    // Calcul de la surface
    override func surface() -> Double {
        Double.pi * grandRAxe * petitAxe
    }
}

class Cercle: Ellipse {
    
    init(centre: Point, rayon: Double, remplissage: Couleur, contour: Couleur) {
        super.init(centre: centre, petitAxe: rayon, grandRAxe: rayon, remplissage: remplissage, contour: contour)
    }
    
    override func perimetre() -> Double {
        2 * Double.pi * petitAxe
    }
}
