//=================================================================================
// Le langage Swift : Apprendre la programmation avec Méthode, Clarté et Concision
// Les Éditions Cristalswift
// www.cristalswift.com
// © 2022 Igor AGBOSSOU
// Chapitre 2. Types de données élémentaires et les opérateurs associés
//==================================================================================

import UIKit

print("Le type Int8 : min = \(Int8.min) et max = \(Int8.max)")

print("Le type Int16 : min = \(Int16.min) et max = \(Int16.max)")

print("Le type Int32 : min = \(Int32.min) et max = \(Int32.max)")

print("Le type Int64 : min = \(Int64.min) et max = \(Int64.max)")

print("Le type Int : min = \(Int.min) et max = \(Int.max)")

print("Le type UInt8 : min = \(UInt8.min) et max = \(UInt8.max)")

print("Le type UInt16 : min = \(UInt16.min) et max = \(UInt16.max)")

print("Le type UInt32 : min = \(UInt32.min) et max = \(UInt32.max)")

print("Le type UInt64 : min = \(UInt64.min) et max = \(UInt64.max)")

print("Le type UInt : min = \(UInt.min) et max = \(UInt.max)")

// Exemple de représentation d'un nombre entier dans plusieurs bases différentes

let leNombre95EnBase10 = 95         // 95
let leNombre95EnBase2 = 0b1011111  // 95
let leNombre95EnBase8 = 0o137       // 95
let leNombre95enBase16 = 0x5f       // 95

// Insertion arbitraire de traits de soulignement dans les littéraux numériques

let populationFrancaiseEn2020 = 67_064_000

// Illustration des différences de précisons entre Float et Double

let simplePrecision: Float = 0.111_111_111 + 0.222_222_222

let doublePrecision: Double = 0.111_111_111 + 0.222_222_222



let simplePrecision1: Float = 0.111_111_166 + 0.222_222_222

let doublePrecision1: Double = 0.111_111_166 + 0.222_222_222

// Addition d'un entier et d'un nombre décimal

let entier = 34
let decimal = 67.98

// 1er cas: Obtention du résultat dans le type Int
let resultatEnInt = entier + Int(decimal) // 101

// 2nd cas : Obtention du résultat dans le type Double
let resultatEndouble = Double(entier) + decimal  // 101.98


