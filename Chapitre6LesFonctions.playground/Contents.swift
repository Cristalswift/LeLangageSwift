//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 6. Comprendre et exploiter les fonctions dans l’univers du langage Swift
//========================================================================================

// Aperçu d'une fonction en action

func imprimeMonNom() {
    print("Je m'appelle Igor AGBOSSOU")
}

// Appelle de votre fonction
imprimeMonNom()   // Je m'appelle Igor AGBOSSOU

// Fonction avec String comme type de la valeur de retour

func retourneMonNom() -> String {
    
    return "Je m'appelle Igor AGBOSSOU"
}

// Pour imprimer la valeur retournée
print(retourneMonNom())

// Fonction avec renvoi implicite de valeur de retour
func renvoiImpliciteDeValeurDeRetour() -> String {
    "Je m'appelle Igor AGBOSSOU"
}
print(renvoiImpliciteDeValeurDeRetour())

// Définition des paramètres d'une fonction
func afficheLIdentiteDe(prenom: String, nom: String) {
    print("Je m'appelle \(prenom) \(nom.uppercased())")
}

// Appelle de la fonction
afficheLIdentiteDe(prenom: "Jean", nom: "Dupont")

// Etiquette des arguments et nom des paramètres
func identiteAvecArguments(argumentPrenom prenom : String, argumentNom nom: String) {
    print("Je m'appelle \(prenom) \(nom.uppercased())")
}
// Appelle de la fonction
identiteAvecArguments(argumentPrenom: "Igor", argumentNom: "Agbossou")

//Arguments identiques aux noms des paramètres.
func identiteAvecMemesArguments(argument prenom: String, argument nom: String){
    print("Je m'appelle \(prenom) \(nom.uppercased())")
}
identiteAvecMemesArguments(argument: "Jean", argument: "Dupont") // Je vous le déconseille.

// Omission d'étiquette d'argument

func multiplicationDe(_ nombre: Double, par: Double) {
    let produit = nombre * par
    print("La multiplication de \(nombre) par \(par) donne \(produit)")
}
multiplicationDe(6, par: 5.8)

// Paramètre par défaut
func messageDeLaDivisionDe(_ numerateur: Double, par denominateur: Double, auteur: String = "Igor") {
    if denominateur == 0 {
        print("Veuillez vérifier que le dénominateur n'est pas nul !")
    } else {
        let quotient = numerateur/denominateur
        print("La division de \(numerateur) par \(denominateur) demandée par \(auteur) est \(quotient)")
    }
}
// Appel de la fonction avec la valeur par défaut
messageDeLaDivisionDe(58, par: 13)

//appel de la fonction sans valeur par défaut
messageDeLaDivisionDe(58, par: 13, auteur: "Vous le lecteur de ce livre,")

// Paramètre variadique

func sommeTotale(de entiers: Int...) -> Int {
    var total = 0
    for entier in entiers {
        total += entier
    }
    return total
}
// Appelle de la fonction sommeTotal(de:...)
let somme = sommeTotale(de: 15, 45, 89, 46) // somme = 195

// Fonction à plusieurs paramètres dont un variadique

func afficherLaSommeEtSonAuteur(_ entiers: Int..., auteur responsable: String) {
    var total = 0
    for entier in entiers {
        total += entier
    }
    print("Le calcul dont le total = \(total) a pour auteur \(responsable).")
}
// Appelle de la fonction afficherLaSommeEtSonAuteur(_: ..., auteur)
afficherLaSommeEtSonAuteur(15, 45, 89, 46, auteur: "Paul")

// Exemple à compliler avec la version 5.4 de Swift...
//func summarizeGoals(times: Int..., jeoueurs players: String...) {
//    let joinedNames = ListFormatter.localizedString(byJoining: players)
//    let joinedTimes = ListFormatter.localizedString(byJoining: times.map(String.init))
//
//    print("\(times.count) goals where scored by \(joinedNames) at the follow minutes: \(joinedTimes)")
//}



// La raison : ce code ne peut pas s'exécuter !

//func impossibleAFaire(aIncrementer valeur: Int) {
//    valeur += 1
//    print(valeur)
//}
//impossibleAFaire(aIncrementer: 7) // Erreur !

// Les paramètres en entrée-sortie

func incrementer(ceNombre valeur: inout Int) {
    
    valeur += 1
    print("la nouvelle valeur est \(valeur)")
}

var maValeur = 9
//Appel de la fonction incrementer(ceNombre: &)
incrementer(ceNombre: &maValeur)    // 10
print(maValeur) // Vérification de la nouvelle valeur de maValeur : 10

// Surcharge de fonction

func combinerLesArguments(nom premier: String, prenom second: String) -> String {
    premier + " " + second
}

func combinerLesArguments(_ premier: String, second: String) -> String {
    premier + " " + second
}

let surcharge1: String = combinerLesArguments(nom: "Jean", prenom: "Dupond")
let surcharge2 = combinerLesArguments("Eric", second: "Klein")


func combinerLesArguments(nom: String, prenom: String) -> Void {
    print("Vous êtes \(nom) \(prenom)")
}

func combinerLesArguments(_ un: Int, _ deux: Int) -> Int {
    un + deux
}

let surcharge3 = combinerLesArguments(12, 22)   // 34

// Fonction à valeur de retour optionnelle

func extraireSecondPrenom(nomComplet etatCivil: (String, String?, String)) -> String? {
    etatCivil.1
}

//Appel de la fonction
let secondPrenom = extraireSecondPrenom(nomComplet: ("Jean", "Igor", "Dupont"))
if let lePrenom = secondPrenom {
    print("Le second prénom est : \(lePrenom)")
}

//Fonction à valeur de retour multiple

func presentationCivile(nom: String, prenom: String, age: Int) -> (String, String, Int) {
    (leNom: nom, LePrenom: prenom, lAge: age)
}

let presentation = presentationCivile(nom: "DURAND", prenom: "Pierre", age: 36)
print(presentation)     //("DURAND", "Pierre", 36)

// Arrêt précoce programmé des fonctions

func saluerParSecondPrenom(usuel prenom: String, intime second: String?) {
    guard let prenomEspere = second
    else {
        print("Bonjour Madame, Monsieur ...")
        return
    }
    print("Bonjour Monsieur \(prenomEspere) !")
}
saluerParSecondPrenom(usuel: "Jean", intime: "Louis")
saluerParSecondPrenom(usuel: "Franck", intime: nil)

// Types des fonctions

func additionner(_ a: Int, _ b: Int) -> Int {
    a + b
}

func soustraire(_ a: Int, de: Int) -> Int {
    de - a
}

// Comment utiliser le type d'une fonction ?
var maFonction: (Int, Int) -> Int  // Annotation de type
maFonction = additionner           // Affectation de valeur

let quatreEtCinq = maFonction(4, 5) // 9

// Affectation par inférence de type à une constante
let uneAutreFonction = soustraire
let deuxSoustraitDeNeuf = uneAutreFonction(2, 9)  // 7

// Changement de valeur pour maFonction
maFonction = soustraire     // OK car maFonction est une variable !
let cinqSoustraitDeQuinze = maFonction(5, 15)   // 10

// Tentative de modification d'une constante. Echec !
// uneAutreFonction = additionner  // Impossible car uneAutreFonction est une constante

// Passage d'une fonction à une autre fonction

func fonctionArgument(_ a: Int, _ b: Int, applique fonction: (Int, Int) -> Int) -> Int {
    fonction(a, b)
}

let resultatAddition = fonctionArgument(12, 25, applique: additionner) // 37
let resultatSoustraction = fonctionArgument(12, 25, applique: soustraire)   // 13

// Fonction comme valeur de retour

/// <#Description#>
/// - Parameter plus: <#plus description#>
/// - Returns: <#description#>
func choisirPlusOuMoins(plus: Bool) -> (Int, Int) -> Int {
    
    plus ? additionner : soustraire
}

let choixFonctionPlus = choisirPlusOuMoins(plus: true)
choixFonctionPlus(12, 25) //37
let choixFonctionMoins = choisirPlusOuMoins(plus: false)
choixFonctionMoins(12, 25)  //13

// Approche de la documentation Doxygen

/// Cette fonction permet de calculer la moyenne arithmétique de trois valeurs et renvoie le résultat
/// - Parameters:
///   - a: La première valeur
///   - b: La deuxième valeur
///   - c: La troisième valeur
/// - Returns: La moyenne arithmétique des trois valeurs
func calculerLaMoyenne(de a: Double, et b: Double, et c: Double) -> Double {
    (a + b + c)/3
}

let moyenne = calculerLaMoyenne(de: 12, et: 22, et: 58) // 30.6666
