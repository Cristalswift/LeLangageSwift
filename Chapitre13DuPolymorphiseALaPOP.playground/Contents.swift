//===================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 13. Du polymorphisme paramétrique à la programmation orientée protocole
//====================================================================================
// Syntaxe de décaltion d'un protocole

protocol MonProtocole {
    //Déclaration des méthodes et propriétés nécessaires
}


//Conformité d'une structure à un protocole
enum MonEnumeration: MonProtocole {
        
    // Implémentation de l'énumération
}

//Conformité d'une structure à un protocole
struct MaStructure: MonProtocole {
    
    // Implémentation de la structure
}

//Conformité d'une structure à un protocole
class MaClasse: MonProtocole {
        
    // Implémentation de la classe
}

// Esquisse des types relatifs à un application de traduction

// Les langues supportées
enum Langue {
    case francais, anglais, espagnol, allemand
}

protocol Identifiable {
    static var languesSupportees: [Langue] { get }
}

// Traduction sans altération du texte d'origine
protocol Immuable: Identifiable {
    static func traduire (en langue: Langue) -> Self
}

//Remplacement du texte d'origine par sa traduction
protocol Mutable {
    mutating func traduire(en langue: Langue)
}

//Composition d'un protocole par combinaison de deux autres
protocol Traduisible: Immuable & Mutable {
    
}

struct Paragraphe: Immuable, Mutable {
    static let languesSupportees: [Langue] = [.francais, .anglais, .allemand, .espagnol]
     
    // Contenu caché en accès privé
    private var texteATraduire = "Bonjour..."
    
    public var contenu: Void {
        print("Voici le contenu du paragraphe: \(texteATraduire)")
    }
    // Implémentation de la version non mutante
    static func traduire(en langue: Langue) -> Paragraphe {
        var resultat = Paragraphe(texteATraduire: "Bonjour...")
        resultat.traduire(en: langue)
        return resultat
    }

    // Implémentation de la version mutante
    mutating func traduire(en langue: Langue) {
        
        switch langue {
            case .anglais: texteATraduire = "Hello..."
            case . allemand: texteATraduire = "Hallo..."
            case . espagnol: texteATraduire = "Buenos dias..."
            case .francais: texteATraduire = "Bonjour..."
        }
    }
}

// Création du paragraphe à traduire
var leParagraphe = Paragraphe()
leParagraphe.contenu // Bonjour...

// Traduction en Espagnol
leParagraphe.traduire(en: .espagnol)
leParagraphe.contenu    // Buenos dias...


//Création d'un nouveau paragraphe déjà traduit en Allemand
let paragrapheEnAllemand = Paragraphe.traduire(en: .allemand)
paragrapheEnAllemand.contenu    // Hallo...

// Définition générique probable des type optionnels par Swift
enum Optional<T> {
    case none
    case some(T)
}

// Fonctions non générigues pour échanger sur place deux valeurs entre elles

// Pour les types Int
func echangerIntSurPlcae(val ceci: inout Int, par cela: inout Int) {
    let attente = ceci
    ceci = cela
    cela = attente
}

// Pour les types Double
func echangerIntSurPlcae(val ceci: inout Double, par cela: inout Double) {
    let attente = ceci
    ceci = cela
    cela = attente
}

// Pour les types String
func echangerIntSurPlcae(val ceci: inout String, par cela: inout String) {
     let attente = ceci
     ceci = cela
     cela = attente
}

//Fonction générique pour échanger sur place deux valeurs, de même type, entre elles

func echangeurGenerique<T>(val ceci: inout T, par cela: inout T) {
    let attente = ceci
    ceci = cela
    cela = attente
}

var intA = 12
var intB = 87

var stringA = "Fabien"
var stringB = "Lola"

// Application de echangeurGenerique(val: &T par: &Ti)
echangeurGenerique(val: &intA, par: &intB)
print("Les valeurs de type Int après échange sont: intA = \(intA) et intB = \(intB)")

echangeurGenerique(val: &stringA, par: &stringB)
print("Les valeurs de type String après échange sont: stringA = \(stringA) et stringB = \(stringB)")

// Autre version générique de fonction d'inversion de valeurs du même type

func autreVersionDEchangeur<Element>(a: Element, b: Element) -> (Element, Element) {
     return (b,a)
}

// Fonction générique de comparaison de deux valeurs du même type
func sontIlsEgaux<Element: Comparable> (a: Element, b: Element) -> Bool {
    return a == b
}

//Définition et conception de type générique
struct Conteneur<T> {
    
    private var contenu = [T]()
    
    var total: Int {
        contenu.count
    }
    
    // Définition et implémentation de la méthode ajout(item:)
    mutating func ajout(item: T) {
        contenu.append(item)
    }
    
    //Définition et implémentation de la méthode pour obtenir la valeur d'un item
    func valeur(a index: Int) -> T? {
        guard index < contenu.count else {
            return nil
        }
        return contenu[index]
    }
}

// Instances différentes de Conteneur avec des types concrets
var stockDeString = Conteneur<String>()
var stockDeDouble = Conteneur<Double>()
var stockDeParagraphes = Conteneur<Paragraphe>()

// Définition d'une classe générique avec contrainte
class ClasseGenerique<T: Comparable> {
    
}

// Définition d'une enum générique
enum EnumGenerique<T> {
    
}

stockDeString.ajout(item: "Je suis à l'aise")
stockDeString.ajout(item: "avec les")
stockDeString.ajout(item: "génériques")
print(stockDeString.total) // 3
print(stockDeString.valeur(a: 2) ?? "") // générique
//print(stockDeString.valeur(a: 1))   // Optional("avec les")


// Définition d'un protocole avec un type associé
protocol Stockable {
    associatedtype E
    var contenu: [E] { get set }
    mutating func ajout(chose: E)
}

//Adoption du protocole Stockable par une structure de nombres entiers
struct TypeEntier: Stockable {
    var contenu: [Int] = []
    mutating func ajout(chose: Int) {
        contenu.append(chose)
    }
}

//Adoption du protocole Stockable par une classe générique
class Fabrique<Produit>:Stockable {
    var contenu: [Produit] = []
    func ajout(chose: Produit) {
        contenu.append(chose)
    }
}
