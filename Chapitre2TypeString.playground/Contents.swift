//=================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 2. Types de données élémentaires et les opérateurs associés
//==================================================================================

let caractereA: Character = "a"
let forceEmoji: Character = "💪"

let animal: String = "chien"
let caractereB = "b"

var salutations = "Bonjour, " + "je m'appelle "
let prenom = "Igor"
salutations += prenom   // Bonjour, je m'appelle Igor

let pointDExclamation: Character = "!"
salutations += String(pointDExclamation)  // Bonjour, je m'appelle Igor !

var personne = "Igor"
var pays = "France"
let annee = 2021
var presentation = "Bonjour, je m'appelle \(personne) de \(pays) et nous sommes en \(annee)"

let longueChaine = """
Vous pouvez afficher une
longue chaîne de caractères
disoposés en plusieurs
lignes en faisant ceci
"""

print(longueChaine)

let monPrenom = "Igor"  // consigne 1
let monNom = "Agbossou" // consigne 1
let monNomEtPrenom = monPrenom + " " + monNom   // consigne 2
let meVoici = "Bonjour, je m'appelle \(monNomEtPrenom)"     // consigne 3

