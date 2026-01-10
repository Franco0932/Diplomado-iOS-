import UIKit

let defaults = UserDefaults.standard

//Save Data
defaults.set(5, forKey: "entero")
defaults.set("Hola", forKey: "string")

//Leer Datos
let entero = defaults.integer(forKey: "entero")
let string = defaults.string(forKey: "string")

print(entero)
print(string)

defaults.set(6, forKey: "string")

let newString = defaults.string(forKey: "string")
print(newString)

let newInt = defaults.integer(forKey: "string")
print(newInt)
