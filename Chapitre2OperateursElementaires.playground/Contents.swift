//=================================================================================
// Le langage Swift : Apprendre la Programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 2. Types de données élémentaires et les opérateurs associés
//==================================================================================

let affectation = 3.5   // On affecte la valeur 3.5 à la constante affectation
let addition = 2 + 6            // résultat : 8
let soustraction = 8 - 2       // résultat : 8
let multiplication = 4 * 2    // résultat : 8
let division = 24 / 3        // résultat : 8

//let additionOK = 2+6
//let additionErreur1 = 2 +6      // Erreur (1)
//let additionErreur2 = 2+ 6      // Erreur (2)

var maVariable = 12
//maVariable = maVariable + 4 // Résultat égal 16

maVariable += 4 // Résultat = 16

let facteur = 6
var facteurPlusDeux = facteur
var facteurFoisDeux =  facteur
var facteurMoinsDeux = facteur
var facteurSurDeux = facteur

// opérateur d'affection composée +=
facteurPlusDeux += 2    // valeur égale 8

// opérateur d'affection composée *=
facteurFoisDeux *= 2    // valeur égale 12

// opérateur d'affection composée -=

facteurMoinsDeux -= 2   // valeur égale 4

// opérateur d'affection composée /=
facteurSurDeux /= 2     // valeur égale 3

let maValeur = 23
let operateurUnaireMoinsSurMaValeur = -maValeur // renvoie la valeur -23

let moinsCinq = -5
let encoreMoinsCinq = +moinsCinq     // valeur -5
let reste = 15 % -4 // reste =  3


2 == 1        // false
2 != 1       // true
2 > 1       // true
2 >= 1     // true
2 < 1     // false
2 <= 1   // false


let ouvrir = true
let fermer = !ouvrir // La valeur de fermer est false, le contraire de ouvrir

var conjonction = ouvrir && !fermer      // true        (1)
conjonction = ouvrir && fermer          // false        (2)
conjonction = fermer && ouvrir         // false         (3)
conjonction = !ouvrir && fermer       // false          (4)

var disjonction = ouvrir || fermer      // true         (1)
disjonction     = fermer || ouvrir     // true          (2)

// Les alias de type

//typealias <#type name#> = <#type expression#>     // Syntaxe générale

typealias Poids = UInt8

// Affichage des valeurs minimale et maximale
let poidsMinimal = Poids.min    // 0
let poidMaximal = Poids.max     // 255

