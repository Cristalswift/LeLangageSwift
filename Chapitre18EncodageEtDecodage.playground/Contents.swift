//==================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 18. Comment encoder puis décoder vos types de données ?
//==================================================================================

//Exemple d'encodage et de décodage automatiques

import Foundation
struct Personne: Codable {
    let nomDeNaissance: String
    let prenom: String
    let genre: Genre
    var nomDUsage: String
    var age: Int
}
//Rendre le type Genre Codable
enum Genre: Codable {
case homme, femme
}

let sandrine = Personne(nomDeNaissance: "DUPONT",
                          prenom: "Sandrine",
                          genre: .femme,
                          nomDUsage: "DURAND",
                          age: 37)

// Initialisation d'un encodeur en JSON
let jsonEncoder = JSONEncoder()
//Conversion de l'instance sadrine de type Personne en JSON
let sandrineEnJSON = try jsonEncoder.encode(sandrine)

//Bien que légitime et utile, cette commande est un peu précipitée à ce stade !
print(sandrineEnJSON)   // 98 bytes

// Demande explicite de presentation textuelle JSON de sandrine
let sandrineEnJSONTextuel = String(data: sandrineEnJSON, encoding: .ascii)!
//Impression textuelle de sandrine en JSON
print(sandrineEnJSONTextuel)

//Processus de décodage d'une donnée JSON en une instance de type
let decodeurJSON = JSONDecoder()
let unePersonne = try decodeurJSON.decode(Personne.self, from: sandrineEnJSON)
// Vérification du résultat
print(unePersonne)

// Remplacement de genre par sexe dans les processus d'encodage et de décodage des instances de Personne
extension Personne {
    
    enum CodingKeys: String, CodingKey {
        case nomDeNaissance
        case prenom
        case genre = "sexe"
        case nomDUsage
        case age
    }
}

//Vérification du résultat
print(sandrineEnJSONTextuel)

// Implémentation personnalisée du processus d'encodage et de décodage
struct Personnel {
    let nom: String
    let prenom: String
    let genre: Genre
}
    
enum ClesJSON: CodingKey {
    case nom
    case prenom
    case sexe
    }


//Implémentation personnalisée de la méthode encode(to:)
extension Personnel: Encodable {
    func encode(to encoder: Encoder) throws {
        //Définition du conteneur de l'encodage
        var conteneur = encoder.container(keyedBy: ClesJSON.self)
        
        //Procéder à l'encodage de chaque propriété en lui attribuant la bonne clé
        try conteneur.encode(nom, forKey: .nom)
        try conteneur.encode(prenom, forKey: .prenom)
        try conteneur.encode(genre, forKey: .sexe)
    }
}

// Petite vérification
let personnel = Personnel(nom: "AGBOSSOU", prenom: "Igor", genre: .homme)
let personnelEnJSON = try jsonEncoder.encode(personnel)
let personnelEnJSONTextuel = String(data: personnelEnJSON, encoding: .utf8)!
print(personnelEnJSONTextuel)

// Implémentation personnalisée de l'initialiseur init(from:)
extension Personnel: Decodable {
    init(from decoder: Decoder) throws {
        //Définition du conteneur des valeurs du décodage
        let valeurs = try decoder.container(keyedBy: ClesJSON.self)
        // Affectation à chaque propriété la valeur de décodage associée via sa clé correspondante
        nom = try valeurs.decode(String.self, forKey: .nom)
        prenom = try valeurs.decode(String.self, forKey: .prenom)
        genre = try valeurs.decode(Genre.self, forKey: .sexe)
    }
}

// Petite vérificartion
let individuEnJSON = """
{
    "nom":"AGBOSSOU",
    "prenom":"Igor",
    "sexe":{ "homme":{} }
}
""".data(using: .utf8)!

let lePersonnel = try decodeurJSON.decode(Personnel.self, from: individuEnJSON)
print(lePersonnel.nom)      // AGBOSSOU
print(lePersonnel.prenom)   // Igor
print(lePersonnel.genre)    // homme
