import UIKit

var greeting = "Hello, playground"
/*
 Reglas básicas, no hay que usar guiones básicos, usar upper... (miVariableUno)
 Aplica con variables, constantes, etc.
 
 let = constante
 
 La diferencia entre variable y constante es el tamaño, la variable ocupa más memoria que una constante.
 */
greeting = "Adios" //Nos permite cambiar el valor de la varible

var miVariableUno = "Varible"

let miConstanteUno = "Constnate"

//miConstanteUno = "Adios" //Marca error porque es constante

var numeroUno = 3, numeroDos = 2, numeroTres = 4

//Tipos de datos
    //Inferencia y no inferencia de tipo.
var texto: String = "Hola"
//texto = 4 //Error porque le asignamos un entero a un tipo de dato string.
var entero: Int = 10
var double: Double = 10.5
var flotante: Float = 10.5
var boolean: Bool = true

    //Numeros
let maxValueInt = Int.max
let minValueInt = Int.min

let maxValueUInt = UInt.max
let minValueUInt = UInt.min

var n1 = 0.1
var n2 = 0.2
var n3: Double = 3.0
let suma = n1 + n2
print(suma) //0.3000000000004

var myVaribale = 0.2 //Float o Double?, es double porque el mismo xcode lo decide???


n1 + n3 //Hay que tener cuidado con el problema de las variables, hay que castear de manera correcta. (Buenas prácticas)
n1 + Double(n3) //Tambien se puede pero es mejor la primera opción.

//MARK: Operadores de Comparación.
n1 > n2 //Mayor que
n1 < n2 //Menor que
n1 >= n2 //Igual o mayor que
n1 <= n2 // Igual o menor que
n1 == n2 //Igual que
n1 != n2 //Diferencia que
//n1 === n2 // Igual que a profundo nivel

//MARK: Strings
let cadena1 = "Hola"
//let cadena2: String  = Hola //No se puede hacer.
let cadena2: String  = " :)"
let nombre = "Franco"
cadena1 + cadena2

//Caracter de escapae
/*
 Nos permite meter información de fuera o valor de nuestro código
 */
let mensaje = "Buenos días \(nombre)"

mensaje.isEmpty


//No hacer esto
    //mensaje.count == 0
//Tampoco esto....
var 👀 = 3
var 😱 = 1

👀 + 😱
// ⬆️

//Arreglos
/*
 Colecciones ordenadas que pueden repetirse
 */
var miArreglo = [1,2,3,4]
var miArreglo2: [Int] = [1,2,3,4]
var miArreglo3: [Int] = [] //Arreglo vacío, hay que declarar de que tipo sería.

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

miArreglo[1]

var miArreglo4: [String] = ["Hola", "Adios"]

//Agregar
miArreglo4.append("Adios")
miArreglo4 += ["Adios", "Bye", "Holi"]
//Modificar
miArreglo4[0] = "iOS"
miArreglo4[1] = "Swift"
//Insertar
miArreglo4.insert("Swift", at: 1)

//Remover
miArreglo4.remove(at: 1)
miArreglo4.removeLast()
miArreglo4

//Otros
miArreglo4.count
miArreglo4.isEmpty

//Sets
var miSet = Set<Int>()
var miSet2 = Set([1,2,3,4])
var miSet3: Set<String> = ["Rock", "Classical", "Hip Hop"]

miSet3.insert("Jazz") //Lo inserta y no lo inserta??
miSet3.remove("Rock")
miSet3.contains("Jazz")//Solo  o indica si lo contiene o no, porque son  un conjunto de elmentos no ordenandos, sirve para elementos únicos y que las busquedas sean más rápidas.
miSet3

//MARK: Diccionarios
/*
 Es un elemento llave valor.
 */
var miDiccionario: [String: Int] = ["Apple": 2, "Banana": 5, "Orange": 4]
var airports: [String:String] = [
    "AIFA": "Benito Juarez",
    "AICM": "Dublim"
]

//Obtener Valor
airports["AICM"]
//Modificar Valor
airports["AIFA"] = "EdoMex"

airports

//Remover
airports["AIFA"] = nil
airports.removeValue(forKey: "AIFA")

var miDiccionario2: [String:String] = [:]

//MARK: Tuplas
var color = ("#ff0000", "Rojo")
var tuplas: (String, Int) = ("Franco Ruiz", 24)
var tuplas2 = (nombre:"Franco Ruiz", edad:24) //Con etiquetas, (va sin castear)

tuplas2.nombre

//MARK: Operadores Lógicos.
//&&
//OR ||
//NOT !

