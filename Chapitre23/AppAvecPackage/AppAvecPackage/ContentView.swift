//=====================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 23. Quels sont les styles d’applications et comment les construit-on ?
//======================================================================================
import SwiftUI
import MonSwiftPackage
import Numerics
struct ContentView: View {
    
    let nombreComplexe = Complex(2, 5)
    
    
    var body: some View {
        Text("Z = " + nombreComplexe.representation)
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
