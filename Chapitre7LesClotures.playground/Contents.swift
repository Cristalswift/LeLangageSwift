//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 7. Comment composer des blocs d’algorithmes grâce aux clôtures ? 
//========================================================================================
import UIKit

// Pourquoi les paramètres des clôtures sont-ils logés dans une paire d'accolades ?

func infoDePaiementClient(client qui: String, facture montant: Double) {
    print("Le client \(qui) a réglé la facture de \(montant) €")
}
infoDePaiementClient(client: "Igor", facture: 45.99)



let infoPaiementViaClosure = { (qui: String, facture: Double) in
    print("Le client \(qui) a réglé la facture de \(facture) €")
}
infoPaiementViaClosure("Julien", 45.99)

// Inférence de type relative aux clôtures

var infoPaiementParInference = { (qui: String, facture: Double) in
    print("Le client \(qui) a réglé la facture de \(facture) €")
}

// Appel de la clôture dans normale
infoPaiementParInference("Fred", 55.9)

// Nouvelle implémentation basée sur l'inférence de type relative aux paramètres
infoPaiementParInference = { (qui, facture) in
    print("Le client \(qui) a réglé la facture de \(facture) €")
}

// Appel de la clôture implémentée sans les types des paramètres
infoPaiementParInference ("Georges", 55.7)

// Nouvelle implémentation sans la liste des paramètres
infoPaiementParInference = {
    print("Le client \($0) a réglé la facture de \($1) €")
}

//Appel de l'impléementation sans la liste des paramètres
infoPaiementParInference("Pierre", 63.99)

// Utilisation des clôtures comme paramètres de fonction


/// Cette fonction prend deux entiers et leur applique une opération arithmétique
/// - Parameters:
///   - a: Nombre entier
///   - b: Nombre entier
///   - operation: L'opération à appliquer
/// - Returns: Résultat sous forme d'un nombre entier
func operationsAvecDeuxEntiers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    
    // On applique opération aux deux entiers
    let resultat = operation(a, b)
    print("Le résultat de l'opération est \(resultat)")
    return resultat
}
// Définition des trois opérations sous forme de clôture

let additionClosure = {(a, b) -> Int in
    a + b
}

let soustractionClosure = {(a, b) -> Int in
    a - b
}

let multiplicationClosure = {(a, b) -> Int in
    a * b
}

// Mise en œuvre des opérations
var addition = operationsAvecDeuxEntiers(12, 7, operation: additionClosure)
var soustraction = operationsAvecDeuxEntiers(12, 7, operation: soustractionClosure)
var multiplication = operationsAvecDeuxEntiers(12, 7, operation: multiplicationClosure)

// Mise en œuvre des opérations avec les opérateurs habituels
addition = operationsAvecDeuxEntiers(15, 11, operation: +)
soustraction = operationsAvecDeuxEntiers(15, 11, operation: -)
multiplication = operationsAvecDeuxEntiers(15, 11, operation: *)

    
// Les trois approches syntaxiques des clôtures à la traîne

// 1- Appel en ligne de la clôture
addition = operationsAvecDeuxEntiers(12, 13, operation: {(a, b) -> Int in a + b })

// 2- Définition en ligne avec les arguments impliciites de la clôture
addition = operationsAvecDeuxEntiers(12, 13, operation: {$0 + $1})

// 3- Appel de la clôture dans le corps de la fonction
addition = operationsAvecDeuxEntiers(12, 13) {
    $0 + $1
}
    
// Clôtures multiples à éa traîne

func fonctionDeClosuresMutiples(premier: () -> Void, second: () -> Void) {
    premier()
    second()
}

// Syntaxe raccourcie spéciale de l'appel
fonctionDeClosuresMutiples {
    print("Je suis l'exécution de la clôture 'premier'.")
} second: {
    
print("Et moi, je suis l'exécution de la clôture 'second'!")
}

// La capture de valeur par les clôtures dans leur environnement contextuel ou portée

var compteur = 0
let closurePourIncrementer = {
    compteur += 1
}
closurePourIncrementer()    // Première fois: compteur = 1
closurePourIncrementer()    // Deuxième fois: compteur = 2
closurePourIncrementer()    // Troisième fois: compteur = 3
print("La valeur actuelle de compteur est: \(compteur)")

func fonctionDePorteeEnglobante() -> () -> Int {
    
    /// Compteur à l'intéerieur de la fonction 'fonctionDePorteeEnglobante'
    var compteur = 0
    let closureIncrementaleDansLaPortee: () -> Int = {
        compteur += 1
        print("La valeur du compteur local est \(compteur)")
        return compteur
    }
    return closureIncrementaleDansLaPortee
}

// Expérimentation de la capture des variables locales

let compteur1 = fonctionDePorteeEnglobante()
let compteur2 = fonctionDePorteeEnglobante()

compteur1() // Première fois: la variable locale compteur = 1
compteur1() // Deuxième fois: la variable locale compteur = 2

compteur2() // Première fois: la variable locale compteur = 1
compteur2() // Deuxième fois: la variable locale compteur = 2

compteur1() // Troisième fois: la variable locale compteur = 3
compteur2() // Troisième fois: la variable locale compteur = 3


// aperçu du générateur de nombre aléatoire intégré dans Swift

print(Int.random(in: 1...10))
// Pour en faire une fonction

func generateurAleatoire() -> Int {
    Int.random(in: 1...10)
}
print(generateurAleatoire())

// La fonction qui renvoie un générateur sous la forme de closure
func usineDuGenerateur() -> () -> Int {
    // Fabrication du générateur
    let generateur = { Int.random(in: 1...10)}
    
    // Expédition du générateur
    return generateur
}

// Mise en route de l'usine
let generateur = usineDuGenerateur()
let nombreAleatoire = generateur()
print("Le nombre aléatoire généré : \(nombreAleatoire)")

//Essayons d’écrire une fonction qui génère des nombres
//aléatoires avec la particularité qu’elle ne doit jamais
//générer un même nombre deux fois de suite.

func fabriquerUnGenerateurSasnDoublon() -> () -> Int {
    
    var valeurInitiale = 0
    
    // Fabrication et expédition du générateur
    return {
        var nombreAleatoireSansDoublon: Int
        
        // La boucle de répétition
        repeat {
            nombreAleatoireSansDoublon = Int.random(in: 1...5)
        } while valeurInitiale == nombreAleatoireSansDoublon
        
        // Mémorisation du nombre précédemment généré
        valeurInitiale = nombreAleatoireSansDoublon
        
        return nombreAleatoireSansDoublon
    }
}

// Test de la fonction au regard du cahier des charges
let generateurSansDoublon = fabriquerUnGenerateurSasnDoublon()
for _ in 1...10 {
    print(generateurSansDoublon())
}
