import UIKit

// MARK: Ejercicio 1
// Crea una variable que guarde un String y una constante que guarde un Int.

var ejerVar: String = "Hola"
let ejerLet: Int = 1

// MARK: Ejercicio 2
// Declara variables de forma explícita para cada tipo:
// un String, un Int, un Double y un Bool.

var ejerCadena: String = "Hola"
var ejerInt: Int = 1
var ejerDouble: Double = 10.99
var ejerBool: Bool = true


// MARK: Ejercicio 3
// Crea dos variables con Double.
// Imprime la división del primero entre el segundo.
// Verifica si el primer número es mayor que el segundo.

var varDouble1: Double = 5.5
var varDouble2: Double = 10.5
var division = varDouble1/varDouble2
print(division)
varDouble1 > varDouble2

// MARK: Ejercicio 4
// Declara dos variables Int.
// Crea una constante que guarde la suma de esas variables.
// Imprime el resultado.

var varCuatro1: Int = 10
var varCuatro2: Int = 15
let resultadoSuma = varCuatro1 + varCuatro2
print(resultadoSuma)


// MARK: Ejercicio 5
// Declara una constante con tu nombre y otra con tu apellido.
// Usa print para mostrar el mensaje:
// "Hola NOMBRE APELLIDO, ¿cómo estás?"

let nombre = "Franco"
let apellido = "Ruiz"

print("Hola \(nombre) \(apellido), ¿cómo estás?")

// MARK: Ejercicio 6
// Crea una tupla llamada `persona` que contenga:
// - un String (nombre)
// - un Int (edad)
// - un Bool (registrado).
// Imprime el valor del nombre

var persona: (String, Int, Bool) = (nombre:"Franco Ruiz", edad:24, resgitrado:true)
persona.0

// MARK: Ejercicio 7
// Crea un Set con los números: 1, 2, 3, 4, 4, 2.
// Agrega un 5 al Set y observa qué sucede.
// Agrega un 1 al Set y observa qué sucede.

var miSet: Set<Int> = ([1,2,3,4,4,2])
miSet.insert(5)
miSet.insert(1)
print(miSet)

// MARK: Ejercicio 8
// Crea un Array con los nombres de 5 frutas.
// Agrega una fruta nueva al Array.
// Imprime la primera y la última fruta de la lista.

var Frutas: [String] = ["Coco", "Manzana", "Limon", "Fresa", "Kiwi"]
Frutas.append("Uva")
print("Primera: \(Frutas.first!)")
print("Ultima: \(Frutas.last!)")


// MARK: Ejercicio 9
// Crea un Diccionario llamado `edades`.
// La clave será un String (nombre).
// El valor será un Int (edad).

var edades: [String:Int] = ["Franco": 24, "Teo": 23, "Rocio": 39]

// MARK: Ejercicio 10
// Describe las principales diferencias entre:
// - un Set
// - un Array
// - un Diccionario

/*
 El array puede darnos orden listado de los objetos que tenemos, el set solo  o indica si lo contiene o no, porque son  un conjunto de elmentos no ordenandos, sirve para elementos únicos y que las busquedas sean más rápidas y el Diccionario solo pone claves y valores
 */
