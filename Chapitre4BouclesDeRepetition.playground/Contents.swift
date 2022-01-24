//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 4. Comment affiner les flux d’instructions en comptant sur les répétitions ?
//========================================================================================

import UIKit

// Principe de fonctionnement de la boucle for...in
// Illustration avec les nombres triangulaires pour une suite de 1 à 10

var somme = 0
for i: Int in 1...10 {
    somme += i
    print ("Itération n°\(i) : somme a pour valeur : \(somme)")
}

// Exemple de calcul d'un nombre élevé à une puissance donnée

let base = 9
let puissance = 12
var resultat = 1

for _ in 1...puissance {
    resultat *= base
}
print("Le nombre \(base) élevé à la puissance \(puissance) donne \(resultat)")

// Impression de tous les multiples de 5 compris entre 1 et 100

for multipleDe5 in 1...100 where multipleDe5 % 5 == 0 {
    print("\(multipleDe5) est un multiple de 5")
}

// Impression de tous les multiples de 5 compris entre 1 et 100
// Code alternatif à l'usage de la clause where
for multipleDe5 in 1...100 {
    if multipleDe5 % 5 == 0 {
        print("\(multipleDe5) est un multiple de 5")
    }
}


//L'instruction continue pour filtrer une boucle

for iterateur in 1...10 {
    if iterateur % 2 == 0 {
        print("\(iterateur) est un nombre pair. Il devrait donc être exclu du résultat !" )
        continue
    }
        print("\(iterateur) est un nombre impair")
}

//L'instruction break

for iterateur in 1...10 {
    if iterateur % 2 == 0 {
        break
    }
    print("\(iterateur) est un nombre impair")
}

// Principe de fonctionnement de la boucle while

var iterateur = 0
var total = 0

while iterateur < 10 {
    iterateur += 1          // (1)
    total += iterateur      // (2)
    print ("Itération n°\(iterateur) : Total a pour valeur : \(total)")
}

// Principe de fonctionnement de la boucle repeat...while

var compteur = 0
var calcul = 0
repeat {
   compteur += 1
    calcul += compteur
    print ("Itération n°\(compteur) : Calcul a pour valeur : \(calcul)")
    
} while compteur < 10

// Un autre exemple de la boucle repeat...while où l’initialisation de la
// variable conditionnelle se fait à l’intérieur du bloc de codes

var valeurAleatoire: Int    // Définition

var nombreDIterations = 0   // Permet de compter le nombre d'itérations avant l'arrêt de la boucle


repeat {
    
    valeurAleatoire = Int.random(in: 1...20)    // Initialisation
    
    nombreDIterations += 1                      // Comptage des itérations
    
    print("La valeur trouvée de manière aléatoire à l'itération n° \(nombreDIterations) est \(valeurAleatoire)")
    
    if valeurAleatoire >= 15 {
        print("La valeur aléatoire qui met fin à la boucle est \(valeurAleatoire)")
    }
    
} while valeurAleatoire < 15

// Algorithme d'une version possible du programme Fizz Buzz

for entier in 1...100 {
    
    if entier % 3 == 0 && entier % 5 == 0 {
        print("FizzBuzz")
    } else if entier % 3 == 0 {
        print("Fizz")
    } else if entier % 5 == 0 {
        print("Buzz")
    } else {
        print(entier)
    }
}






