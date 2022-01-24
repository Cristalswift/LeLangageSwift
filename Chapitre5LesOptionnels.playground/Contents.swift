//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 5. Comment tirer avantage des types optionnels de données ?
//========================================================================================

var codeErreur = 0              // valeur sentinelle

var nomEtPrenom = "Igor AGBOSSOU"
var age = 40
var profession = "Professeur, développeur d'applications scientifiques et auteur"

// Format long et explicite de la syntaxe des optionnels

var maBoite: Optional<Int>      // Etape 1: Annotation de type
maBoite = Optional(5)           // Etape 2: Affectation de valeur


// Format court de la syntaxe des optionnels
var maBoite2: Int?
maBoite2 = 5
print(maBoite2 as Any)
print(maBoite as Any)

// Mécanisme d'accès aux valeurs des types optionnels

var resultat: Int? = 30
print(resultat as Any)         // Optional(30)

// Récupération forcée de la valeur d'un type optionnel
var stringOptionnel: String? = "Le langage Swift"
print(stringOptionnel as Any)
var stringRecupereDeForce = stringOptionnel!
print(stringRecupereDeForce)

// Regardons se qui se passe en cas d'absence de valeur
stringOptionnel = nil
//print(stringOptionnel!)         // Erreur fatale

if stringOptionnel != nil {
    print("Le contenu est : \(stringOptionnel!)")
} else {
    print("Il n'y a pas de contenu ")
}

// Application de la liaison optionnelle sur des variables optionnelles

// Cas de stringOptionnel qui contient nil

if let contanteTemporaire = stringOptionnel {
    print(contanteTemporaire)       // Il ne se passe rien
}

// Cas de resultat qui contient Optional(30)

if let constanteTemporaire = resultat {
       print(constanteTemporaire)   // Valeur entière 30, de type Int et non Optional(30)
}

// Application de la liaison optionnelle avec if var

if var variableTemporaire = resultat {
    print("Valeur récupérée dans variableTemporaire : \(variableTemporaire)")
    
    variableTemporaire += 15
    
    print("Valeur de variableTemporaire après mofidication : \(variableTemporaire)")
}

// Aperçu des tuples optionnels

var tuple1: (un: String, deux: Int)?
var tuple2: (un: String?, deux: Int)

// Optionnel implicitement récupéré
var stringOptionnelImplicite: String! = "Valeur optionnelle implicite"
print(stringOptionnelImplicite as Any)    // Optional("Valeur optionnelle implicite")

let copieStringOptionnelImplicite = stringOptionnelImplicite
print(copieStringOptionnelImplicite as Any)        // Optional("Valeur optionnelle implicite")

let vraiString: String = stringOptionnelImplicite
print(vraiString)                           // "Valeur optionnelle implicite"


// Que se passe-t-il lorsque stringOptionnelImplicite contient nil ?

stringOptionnelImplicite = nil
let copieOptionnelVide = stringOptionnelImplicite   // Que se passe-t-il ?
print(type(of: copieOptionnelVide))                 // De type optionnel - String?

// Aucune de ces deux lignes de codes ne pourra s'exécuter (Erreur fatale !!!), pourquoi ?
//var variableAnnoteeParCopieOptionnelVide: String = stringOptionnelImplicite
//let constanteAnnoteeParCopieOptionnelVide: String = stringOptionnelImplicite


// Exemple d'enchaînement optionnel
var codeErreurConnexionEnStringOptionnel: String? = "404"
var descriptionErreurEnStringOptionnel: String?

if let quelleErreur = codeErreurConnexionEnStringOptionnel,
   let codeNumerique = Int(quelleErreur),
   codeNumerique == 404 {
    descriptionErreurEnStringOptionnel = "\(codeNumerique + 200) : ressource introuvable !"
}

var descriptionMajusculeParChainageOptionnel = descriptionErreurEnStringOptionnel?.uppercased()
print(descriptionMajusculeParChainageOptionnel as Any)

// Modification sur place des optionnels

descriptionMajusculeParChainageOptionnel?.append(" VEUILLEZ REESSAYER !")
print(descriptionMajusculeParChainageOptionnel as Any)

// Nécessité de l'opérateur à fusion nulle
let messagePositif: String
if let tempo = descriptionMajusculeParChainageOptionnel {
    messagePositif = tempo
} else {
    messagePositif = "Aucune erreur à signaler !"
}
print(messagePositif)

// Utilisation de l'opérateur à fusion nulle

// C'est ici que la magie opère...
let messagePositifParFusion = descriptionMajusculeParChainageOptionnel ?? "Aucune erreur à signaler !"
print(messagePositifParFusion)

let constanteOptionnelle: String? = "23"
print(constanteOptionnelle)

