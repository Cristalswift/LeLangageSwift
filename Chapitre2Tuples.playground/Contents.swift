//=================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 2. Types de données élémentaires et les opérateurs associés
//==================================================================================
let coordonnees = (12, 32)

let personne: (String, String, Int) = ("Igor", "M", 40)

let x = coordonnees.0   // renvoie la valeur 12
let y = coordonnees.1   // renvoie la valeur 32

let nom = personne.0    // renvoie la valeur "Igor"
let sexe1 = personne.1   // renvoie la valeur "M"
let age1 = personne.2    // renvoie la valeur 40

let coordeonneesExplicites = (abscisse: 12, ordonnee: 32)
let valeurX = coordeonneesExplicites.abscisse   // renvoie la valeur de l'abscisse = 12
let valeurY = coordeonneesExplicites.ordonnee   // renvoie la valeur de l'ordonnee = 32

let personneExplicite = (prenom: "Igor", sexe: "M", age: 40)
let prenom = personneExplicite.prenom   // renvoie la valeur du prénom = Igor
let sexe = personneExplicite.sexe       // renvoie la valeur du sexe = M
let age = personneExplicite.age         // renvoie la valeur de l'âge = 40


type(of: coordeonneesExplicites) // renvoie (abscisse: Int, ordonnee: Int).Type
type(of: personneExplicite)     // renvoie (prenom: String, sexe: String, age: Int).Type

let (_, _, a) = personne

enum Direction { //Le mot enum est un mot réservé du langage pour pour qualifier un type énuméré
    case nord   // Le mot case est un mot réservé du langage pour désigner cahque cas ou item ou modalité d'un type énuméré
    case sud
    case est
    case ouest
}

let directionNord = Direction.nord
var uneDirection = Direction.sud

uneDirection = .ouest



