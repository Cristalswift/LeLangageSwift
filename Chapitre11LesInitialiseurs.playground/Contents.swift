//=======================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 11. Comment planifier l’instanciation de vos types grâce à l’initialisation ?
//========================================================================================


//struct Meteo {
//    var ville = "Besançon"
//    var temperatureCelsius = 23.5
//    var temperatureFahrenheit = 74.3
//    var temperatureKelvin = 296.65
//    func flashInfo() {
//        print("A \(ville), il fait actuellement \(temperatureCelsius)° Celsius")
//    }
//}

// Instanciation avec l'initialiseur par défaut fournit par le compilateur Swift
var maMeteo = Meteo()
maMeteo.flashInfo()


struct Meteo2 {
    var ville: String
    var temperatureCelsius: Double
    var temperatureFahrenheit: Double
    var temperatureKelvin: Double
    func flashInfo() {
        print("A \(ville), il fait actuellement \(temperatureCelsius)° Celsius")
    }
    
}
// Instanciation avec une autre forme d'initialiseur par défaut.
var maMeteo2 = Meteo2(ville: "Strasbourg", temperatureCelsius: 23.5, temperatureFahrenheit: 74.3, temperatureKelvin: 296.65)
maMeteo2.flashInfo()


struct Meteo3 {
    var ville: String
    var temperatureCelsius: Double
    var temperatureFahrenheit: Double {
            1.8 * temperatureCelsius + 32
    }
    var temperatureKelvin: Double {
        temperatureCelsius + 273.15
    }
    func flashInfo() {
        print("A \(ville), il fait actuellement \(temperatureCelsius)° Celsius")
    }
}
// Instanciation avec une autre forme d'initialiseur par défaut.
var maMeteo3 = Meteo3(ville: "Paris", temperatureCelsius: 23.5)
maMeteo3.flashInfo()
maMeteo3.temperatureFahrenheit
maMeteo3.temperatureKelvin

//Modélisation de la structure Meteo
struct Meteo {
    let ville: String
    var temperatureCelsius: Double
       
    var temperatureFahrenheit: Double {
            1.8 * temperatureCelsius + 32
    }
    var temperatureKelvin: Double {
        temperatureCelsius + 273.15
    }
    
//    // initialiseur personnalisé avec valeur par défaut des paramètres
//    init(ville: String = "Besançon", temperatureCelsius: Double = 23.5) {
//        self.ville = ville
//        self.temperatureCelsius = temperatureCelsius
//    }
    
    // initialiseur personnalisé avec noms d'arguments
    init(ville nom: String, temperature enCelsius: Double ) {
        ville = nom
        temperatureCelsius = enCelsius
    }
    
    // Déléguation d'initialisation avec valeur par défaut des paramètres à un autre initialiseur
    init(ville: String = "Besançon", temperatureCelsius: Double = 23.5) {
        self.init(ville: ville, temperature: temperatureCelsius)
    }
    
    
    
    func flashInfo() {
        print("A \(ville), il fait actuellement \(temperatureCelsius)° Celsius")
    }
}
// Création d'une instance avec les paramètres par défaut
var meteoABesancon = Meteo()
meteoABesancon.flashInfo()

// Création d'une instance personnalisée
var meteoALyon = Meteo(ville: "Lyon", temperatureCelsius: 25)
meteoALyon.flashInfo()

//============= Initialiseurs désignés et initialiseurs de convenance ===

class MeteoRegionale {
    let region: String
    var donnees: [Meteo]
    let nombreDeStations: Int
    
//    // Définition et implémentation d'un initialiseur désigné par défaut
//    init() {
//        region = "Bourgogne Franche-Comté"
//        donnees = [Meteo]()
//        nombreDeStations = 8
//    }
    
    // Définition et implémentation d'un initialiseur désigné avec paramètres par défaut
    init(region: String = "Bourgogne Franche-Comté", donnees: [Meteo] = [Meteo](), nombreDeStations: Int = 8) {
        self.region = region
        self.donnees = donnees
        self.nombreDeStations = nombreDeStations
    }
    
//    // Définition et implémentation d'un initialiseur désigné avec paramètres
//    init(region nom: String, donnees releves: [Meteo], nombreDeStations totalRegional: Int) {
//        region = nom
//        donnees = releves
//        nombreDeStations = totalRegional
//    }
    
    // Initialiseur de convenance à partir de nom de la région
    convenience init(region: String) {
        self.init(region: region, donnees: [Meteo](), nombreDeStations: 8)
    }
    // Initialiseur de convenance à partir de nom de la région et le nombre de stations
    convenience init(region: String, nombreDeStations: Int) {
        self.init(region: region, donnees: [Meteo](), nombreDeStations: nombreDeStations)
    }
    
    // Initialiseur de convenance à partir d'un nom de région et d'un dictionnaire
    // composé d'une liste de noms de villes avec la température qui y est relevée
    convenience init(region: String, donneesMeteo: [String: Double]) {
        // On crée un conteneur pour stoker le nom de la ville ainsi que la température relevée
        var villesEtTemperatures = [Meteo]()
        
        // Pour chaque paire (ville : température),
        for paire in donneesMeteo {
            // On crée la structure Meteo et on la stocke dans le conteneur
            villesEtTemperatures.append(Meteo(ville: paire.key, temperature: paire.value))
        }
        // On appelle maintenant l'initialiseur désigné auquel on transfère les valeurs
        self.init(region: region, donnees: villesEtTemperatures, nombreDeStations: villesEtTemperatures.count)
    }
    
    convenience init?(nomDeregion: String, donnees: [Meteo], nombreDeStations: Int) {
        guard !nomDeregion.isEmpty && nombreDeStations > 1 else {
            return nil
        }
        self.init(region: nomDeregion, donnees: donnees, nombreDeStations: nombreDeStations)
    }
}

var meteoBFC = MeteoRegionale()
meteoBFC.donnees = [Meteo(), Meteo(ville: "Dijon", temperature: 27.00)]
print(meteoBFC.donnees)

let meteoIleDeFrance = MeteoRegionale(region: "île-de-France", donnees: [Meteo](), nombreDeStations: 8)

let meteoRegionaleOptionnelle = MeteoRegionale(nomDeregion: "", donnees: [Meteo](), nombreDeStations: 4)
print(type(of: meteoRegionaleOptionnelle))
