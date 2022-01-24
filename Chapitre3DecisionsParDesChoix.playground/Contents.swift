//=================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 3. Comment prendre des décisions en faisant des choix ?
//====================================================================================
let scoreEquipe1 = 7
let scoreEquipe2 = 6

// Instruction if
if scoreEquipe1 > scoreEquipe2 {
    print("L'équipe n°1 a remporté !")
}

// Instruction if...else
if scoreEquipe1 > scoreEquipe2 {
    print("L'équipe n°1 a remporté !")
}
else {
    print("L'équipe n°2 a remporté !")
}

// Instruction if...esle if...else
if scoreEquipe1 > scoreEquipe2 {
    print("L'équipe n°1 a remporté !")
}
else if scoreEquipe2 > scoreEquipe1 {
    print("L'équipe n°2 a remporté !")
}
else {
    print("Les deux équipes sont à égalité !")
}

// L'évaluation en court-circuit

let nom = "Paul"
if 1 > 2 && nom == "Igor" {
    // fait quelque chose !
  print("La valeur de la constante nom est \(nom)") // Pas d'exécution !
}

if 1 < 2 || nom == "Igor" {
    // fait quelque chose !
    print("La valeur de la constante nom est \(nom)") // Exécution avec Paul comme résultat
}

// L'encapsulation de variables

var heuresTravaillees = 45

var redevance = 0
if heuresTravaillees > 40 {                         // true
    let heuresAuDelaDe40 = heuresTravaillees - 40   // 5 heures
    redevance += heuresAuDelaDe40 * 50              //  0 + 250
    heuresTravaillees -= heuresAuDelaDe40           // 45 - 5 = 40
}

redevance += heuresTravaillees * 25                 // 250 + 40 * 25 = 1250

print("La facture totale à payer est de \(redevance) €")

//print(heuresAuDelaDe40)

// Opérateur conditionnel ternaire

heuresTravaillees = 45

let heuresSup = heuresTravaillees > 40 ? heuresTravaillees - 40 : heuresTravaillees

print("Le total d'heures travaillées à delà de 40 est de \(heuresSup)")

// Autre exemple simple

let nombre1 = 12
let nombre2 = 23

let min: Int        // à déterminer !
let max: Int        // à déterminer !

// Détermination du min
if nombre1 < nombre2 {
    min = nombre1
} else {
    min = nombre2
}

// Détermination du max
if nombre1 > nombre2 {
    max = nombre1
} else {
    max = nombre2
}

print ("Le min est \(min) et le max est \(max)")

let a = 2
let b = 9
let minimum: Int // à déterminer avec l'opérateur condition ? valeur vraie : valeur fausse
let maximum: Int // à déterminer avec l'opérateur condition ? valeur vraie : valeur fausse
minimum = a < b ? a : b
maximum = a > b ? a : b

print("Le minimun est \(minimum) et le maximum est \(maximum)")

//Illustration de l'instruction guard...else

//guard true else {
//    print("Les conditions ne sont pas réunies !") // Ne sera pas exécuté !

//}
print("Les conditions sont bonnes!")
//
//guard false else {
//    print("Les conditions ne sont pas réunies, c'est la clause 'else' qui devrait s'exécuter !")
//    return
//}
//print("Les conditions sont bonnes!")

// L'instruction switch

let nombre = 10
switch nombre {
case 0:
    print("Ce cas porte l'étiquette 0. Ce n'est pas le nombre attendu !")
default:
    print("Échec de correspondance. Le mombre attendu est \(nombre) !")
}

switch nombre {
case 0:
    print("Ce cas porte l'étiquette 0. Ce n'est pas le nombre attendu !")
case 10:
    print("Bravo, le nombre attendu est bien 10 !")
default:
    print("Échec de correspondance. Le mombre attendu est \(nombre) !")
}

switch nombre {
case 0:
    print("Ce cas porte l'étiquette 0. Ce n'est pas le nombre attendu !")
case 10:
    break
default:
    print("Échec de correspondance. Le mombre attendu est \(nombre) !")
}

let heure = 12
var momentDeLaJournee = " "
switch heure {
case 0, 1, 2, 3, 4, 5 :                                 // Cas n°1
    momentDeLaJournee = "On est à l'aube"
case 6, 7, 8, 9, 10:                                    // Cas n°2
    momentDeLaJournee = "On est dans la matinée"
case 11:                                                // Cas n°3
    momentDeLaJournee = "On est en fin de matinée"
case 12:                                                // Cas n°4
    momentDeLaJournee = "Il est midi"
case 13, 14:                                            // Cas n°5
    momentDeLaJournee = " On est entre midi et deux"
case 15:                                                // Cas n°6
    momentDeLaJournee = "On est en début d'après-midi"
case 16, 17:                                            // Cas n°7
    momentDeLaJournee = "On est dans l'après-midi"
case 18:                                                // Cas n°8
    momentDeLaJournee = "On est en fin d'après-midi"
case 19, 20, 21:                                        // Cas n°9
    momentDeLaJournee = "on est en soirée"
case 22, 23 :                                           // Cas n°10
    momentDeLaJournee = "C'est la nuit"
default:                                                // Cas par défaut
    momentDeLaJournee = "Heure invalide !"
}
print(momentDeLaJournee)

// La syntaxe des intervalles fermés

let intervalleFerme = 0...5

// La syntaxe des intervalles semi-ouverts

let intervalleSemiOuvert = 0..<5

// Même code avec des intervalles

switch heure {
case 0...5 :                                                // Cas n°1
    momentDeLaJournee = "On est à l'aube"
case 6...10:                                                // Cas n°2
    momentDeLaJournee = "On est dans la matinée"
case 11:                                                    // Cas n°3
    momentDeLaJournee = "On est en fin de matinée"
case 12:                                                    // Cas n°4
    momentDeLaJournee = "Il est midi"
case 13..<15:                                               // Cas n°5
    momentDeLaJournee = " On est entre midi et deux"
case 15:                                                    // Cas n°6
    momentDeLaJournee = "On est en début d'après-midi"
case 16..<18:                                               // Cas n°7
    momentDeLaJournee = "On est dans l'après-midi"
case 18:                                                    // Cas n°8
    momentDeLaJournee = "On est en fin d'après-midi"
case 19...21:                                               // Cas n°9
    momentDeLaJournee = "on est en soirée"
case 22..<24 :                                              // Cas n°10
    momentDeLaJournee = "C'est la nuit"
default:                                                    // Cas par défaut
    momentDeLaJournee = "Heure invalide !"
}
print(momentDeLaJournee)

// La correspondance partielle via les tuples et le caractère Joker

var unPoint = (2, 0)
var localisation = " "

switch unPoint {
case (0, 0):
    localisation = " \(unPoint) correspond à l'origine du repère"
case (_, 0):
    localisation = " \(unPoint) est situé sur l'axe des abscisses"
case (0, _) :
    localisation = " \(unPoint) est situé sur l' axe des ordonnées"
case (-3...3, -3...3):
    localisation = " \(unPoint) fait partie du nuage de points"
    
default:
    localisation = "\(unPoint) est situé en dehors du nuage de points"
}
print(localisation)

// Le mécanisme de liaison de valeurs

switch unPoint {
case (0, 0):
    localisation = " \(unPoint) correspond à l'origine du repère"
case (let x, 0):                                                    // Cas n°2
    localisation = " \(unPoint) est situé sur l'axe des abscisses précisément à \(x)"
case (0, let y) :                                                   // Cas n°3
    localisation = " \(unPoint) est situé sur l' axe des ordonnées précisément à \(y)"
case (let a, let b):                                                // Cas n°4
    localisation = " Le point a pour abscisse \(a) et pour ordonnée \(b)"
    
}
print(localisation)

// Le recours à l'étiquette fallthrough

switch unPoint {
case (0, 0):
    localisation = " \(unPoint) correspond à l'origine du repère"
case (let x, 0):                                                    // Cas n°2
    localisation = " \(unPoint) est situé sur l'axe des abscisses précisément à \(x)"
case (0, let y) :                                                   // Cas n°3
    localisation = " \(unPoint) est situé sur l' axe des ordonnées précisément à \(y)"

case (let a, let b):                                                // Cas n°4
    localisation = " Le point a pour abscisse \(a) et pour ordonnée \(b)"
    fallthrough
case (-3...3, -3...3):
    localisation = " Le point de coordonnées \(unPoint) fait bien partie du nuage"
    
}
print(localisation)

// Le filtre sélectif ou conditionnel avec la clause where
switch unPoint {

case (let a, let b) where a == b:          // Cas de la diagonale principale
    localisation = "Le point \(unPoint) se situe sur la diagonale principale"
case (let a, let b) where a == -b:          // Cas de la diagonale secondaire
    localisation = "Le point \(unPoint) se situe sur la diagonale secondaire"
case (let a, let b):                                          // Cas général
    localisation = " Le point a pour abscisse \(a) et pour ordonnée \(b)"
    fallthrough
case (-3...3, -3...3):
    localisation = " Le point de coordonnées \(unPoint) fait bien partie du nuage"
    
}
print(localisation)
