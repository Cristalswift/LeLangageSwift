//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 9. Comment concevoir vos propres types enum, struct clas et pourquoi ?
//========================================================================================


// =============== Les types enum =========================

// Syntaxe de prise en charge des enum
// 1- Conception du type AppareilMobile
enum AppareilMobile {
    case iPod (modele: String, annee: Int, capacite: Int, prix: Double )
    case iPhone (modele: String, annee: Int, capacite: Int, prix: Double )
    case iPad (modele: String, annee: Int, capacite: Int, prix: Double )
}
// 2- Exemples d'utilisation (des instances de AppareilMobile)
let monTelephone = AppareilMobile.iPhone(modele: "Pro", annee: 2019, capacite: 256, prix: 1350)
let maTablette = AppareilMobile.iPad(modele: "Pro", annee: 2020, capacite: 1024, prix: 1839)

// 3- Fonction pour afficher les données relatives à une instance de AppareilMobile
func donneesAppareilMobile(de appareil: AppareilMobile) {
    switch appareil {
        case .iPod(let modele, let annee, let capacite, let prix):
            print("iPod: \(modele), de \(annee), \(capacite) au prix de \(prix) ")
        case .iPhone(let modele, let annee, let capacite, let prix):
            print("iPhone: \(modele), de \(annee), \(capacite) au prix de \(prix) ")
        case .iPad(let modele, let annee, let capacite, let prix):
                print("iPad: \(modele), de \(annee), \(capacite) au prix de \(prix) ")
    }
}

// 4- Test sur les instances monTelephone et maTablette
donneesAppareilMobile(de: monTelephone)
donneesAppareilMobile(de: maTablette)


enum FeuTricolore: String, CaseIterable{
    case rouge = "STOP, le feu est au rouge !"
    case vert = "Le feu est au vert, vous pouvez circuler"
    case orange = "ATTENTION..., le feu est déjà à l'orange"
}

//Fonction pour afficher le message relatif à une couleur
func messageDuFeuTricolore(pour couleur: FeuTricolore) {
    let couleurEnMajuscule = String("\(couleur)").uppercased()
    print("\(couleurEnMajuscule) : \(couleur.rawValue)")
}
messageDuFeuTricolore(pour: FeuTricolore.orange)

//Fonction pour afficher les messages relatifs à toutes les couleurs
func messageDuFeuTricolore() {
    for couleur in FeuTricolore.allCases {
        messageDuFeuTricolore(pour: couleur)
    }
}
messageDuFeuTricolore()


//// Syntaxe de prise en charge des enum
//enum AppareilMobile: String {
//    case iPod = "iPod"
//    case iPhone = "iPhone"
//    case iPad = "iPad"
//}

// Les énumrations récursives sur quelques cas
enum Filiation {
    case enfant (nom: String, age: Int)
    indirect case pere (filiation: Filiation)
    indirect case mere (filiation: Filiation)
}

// Les énumérations récursives sur tous les cas
indirect enum ExpressionArithmetique {
    case nombre(Int)
    case addition(ExpressionArithmetique, ExpressionArithmetique)
    case multiplication(ExpressionArithmetique, ExpressionArithmetique)
}

// Exploitation de ExpressionArithmetique pour (7+2)*3
// Les nombres séparément
let sept = ExpressionArithmetique.nombre(7)
let deux = ExpressionArithmetique.nombre(2)
let trois = ExpressionArithmetique.nombre(3)

// La partie additive : (7+2)
let laSomme = ExpressionArithmetique.addition(sept, deux)
// L'expression (7+2)*3
let leProduit = ExpressionArithmetique.multiplication(laSomme, trois)

// Implémentation de l'algorithme de calcul de la
// valeur des instances de ExpressionArithmetique
func calculerLaValeur(de expression: ExpressionArithmetique) -> Int {
    switch expression {
        
        // Le cas où expression est un nombre entier
        case let .nombre(entier):
            return entier
            
        // Le cas où expression est une addition
        case let .addition(partieGauche, partieDroite):
        return calculerLaValeur(de:partieGauche) + calculerLaValeur(de: partieDroite)
        
        // Le cas où expression est une multiplication
        case let .multiplication(multiplicande, multiplicateur):
        return calculerLaValeur(de: multiplicande) * calculerLaValeur(de: multiplicateur)
            
    }
}

// Utilisation de la fonction calculerLaValeur(de:)
print(calculerLaValeur(de: leProduit)) // 27

//=================== Les types struct =============================

// Définition d'un type struct nommé Personne
struct Personne {
    let nomDeNaissance: String
    var nomDUsage: String
    var age: Int
}

// Créaton d'une instance du type Personne
var aline = Personne(nomDeNaissance: "Dupond", nomDUsage: "Berger", age: 34)
print(aline)

// Caractéristique principale des types de valeur : La sémantique de valeur
var celine = aline
var sabine = aline
print("Céline = \(celine)")
print("Sabine = \(sabine)")

// Changement des valeurs de celine
celine.age = 45
celine.nomDUsage = "Ducro"

// Changement des valeurs de sabine
sabine.age = 55
sabine.nomDUsage = "Chriac"

// Que se passe-t-il ?
print("Aline = \(aline)")
print("Sabine = \(sabine)")
print("Céline = \(celine)")

// Définition d'un type class nommé PersonneClasse
class PersonneClasse {
    var nomDeNaissance: String
    var nomDUsage: String
    var age: Int
    
    // initialiseur
    init(nomDeNaissance: String, nomDUsage: String, age: Int) {
        self.nomDeNaissance = nomDeNaissance
        self.nomDUsage = nomDUsage
        self.age = age
    }
}

// Création d'une instance de PersonneClasse
var alineClasse = PersonneClasse(nomDeNaissance: "Dupond", nomDUsage: "Berger", age: 34)
print(alineClasse)
print("Rose: \(alineClasse.nomDUsage), age = \(alineClasse.age) ans")

// Définition d'un type class nommé Entreprise
class Entreprise {
   var nom: String
    var pdg: PersonneClasse
    
    init(nom: String, pdg: PersonneClasse){
        self.nom = nom
        self.pdg = pdg
    }
}
let patron = PersonneClasse(nomDeNaissance: "Roche", nomDUsage: "Roche", age: 28)
let societe = Entreprise(nom: "Cristalswift", pdg: patron)
print(societe)
print(societe.pdg)
print(societe.nom)


// Caractéristique principale des types de référence : La sémantique de référence
var celineClasse = alineClasse
var sabineClasse = alineClasse
print("CélineClasse = \(celineClasse)")
print("SabineClasse = \(sabineClasse)")

// 1- Changement des valeurs de celineClasse
celineClasse.age = 45
celineClasse.nomDUsage = "Ducro"

// Que se passe-t-il après modification, quand on fait appel aux instances de classe ?
print("SabineClasse ==> nom d'usge : \(sabineClasse.nomDUsage), age: \(sabineClasse.age)")
print("CélineClasse ==> nom d'usage \(celineClasse.nomDUsage), age : \(celineClasse.age)")

// 2- Changement des valeurs de sabineClasse
sabineClasse.age = 55
sabineClasse.nomDUsage = "Chriac"

// Que se passe-t-il après modification, quand on fait appel aux instances de classe ?
print("SabineClasse ==> nom d'usge : \(sabineClasse.nomDUsage), age: \(sabineClasse.age)")
print("CélineClasse ==> nom d'usage \(celineClasse.nomDUsage), age : \(celineClasse.age)")
