import UIKit

//// MARK: Ejercicio 1
//Escribe una función operacion que reciba dos enteros y un closure que indique la
//operación a realizar (+, -, *, /).
//El closure debe devolver el resultado.
//Prueba la función con diferentes operaciones.
//⸻
func operacion(ent1: Int, ent2: Int, operacionARealizar: (Int, Int) -> Int) -> Int {
    return operacionARealizar(ent1, ent2)
}

let suma = operacion(ent1: 1, ent2: 2, operacionARealizar: { (a, b) in
    return a + b
})

let resta = operacion(ent1: 1, ent2: 2, operacionARealizar: { ($0 - $1)})

let mult = operacion(ent1: 5, ent2: 10, operacionARealizar: { (a, b) in
    return a * b
})

let div = operacion(ent1: 100, ent2: 50, operacionARealizar: { (a, b) in
    return a / b
})


//// MARK: Ejercicio 2
//Crea una función esMayorQue que reciba dos enteros y un closure que devuelva true
//si el primer número es mayor que el segundo.
//Usa la función con diferentes pares de números.
//⸻

func esMayorQue (num1: Int, num2: Int, comparar: (Int, Int) -> Bool) -> Bool {
    return comparar(num1, num2)
}

let mayorQue = esMayorQue(num1: 10, num2: 5, comparar: { $0 < $1 })
let mayorQue2 = esMayorQue(num1: 3, num2: 7, comparar: { $0 > $1 }) 
let mayorQue3 = esMayorQue(num1: 8, num2: 8, comparar: { $0 >= $1 })
let mayorQue4 = esMayorQue(num1: 4, num2: 2, comparar: { $0 < $1 })

print(mayorQue)
print(mayorQue2)
print(mayorQue3)
print(mayorQue4)


/// MARK: Ejercicio 3
//Crea una función procesarCadenas que reciba un arreglo de String y un closure que
//combine dos cadenas en una.
//La función debe recorrer el arreglo y combinar todos los elementos usando el closure,
//devolviendo el resultado final.
//Ejemplo de uso:
//•
//•
//•
//Arreglo: ["Swift", "es", "genial"]
//Closure: concatenar con espacio " "
//Resultado: "Swift es genial"
//⸻

func procesarCadenas (arreglo: [String], combinarCadenas: (String, String) -> String) -> String {
    var resultado = ""
    for cadena in arreglo {
        resultado = combinarCadenas(resultado, cadena)
    }
    return resultado
}

let arreglo = ["Swift", "es", "genial"]
let resultado = procesarCadenas(arreglo: arreglo, combinarCadenas: { (cadena1, cadena2) in
    if cadena1.isEmpty {
        return cadena2
    } else {
        return cadena1 + " " + cadena2
    }
})  
print(resultado)

//// MARK: Ejercicio 4
//Escribe una función compararStrings que reciba dos cadenas de texto y un closure
//que defina la comparación (por ejemplo: si son iguales, si una es más larga que la otra,
//etc.).
//El resultado debe imprimirse en consola.
//⸻

func compararStrings(cadena1: String, cadena2: String, comparar: (String, String) -> Bool) {
    let resultado = comparar(cadena1, cadena2)
    if resultado {
        print("Son igaules")
    } else {
        print("Una es más larga que la otra")
    }
}

let comparar = compararStrings(cadena1: "Hola", cadena2: "Hola", comparar: { (a, b) in
    return a == b
})  
let comparar2 = compararStrings(cadena1: "Swift es Genial", cadena2: "Swift is Great!", comparar: { (a, b) in
    return a.count == b.count
})
let comparar3 = compararStrings(cadena1: "iOS 26", cadena2: "macOS 26", comparar: { (a, b) in
    return a.count > b.count

//// MARK: Ejercicio 5
//Crea una función transformarTexto que reciba un String y un closure.
//El closure debe transformar el texto (ejemplo: pasarlo a mayúsculas, agregarle un
//prefijo, invertirlo).
//Devuelve el resultado.
//⸻

func transformarTexto(texto: String, transformar: (String) -> String) -> String {
    return transformar(texto)
}

let textoTransformado = transformarTexto(texto: "Diplomado de Desarrollo de Aplicaciones Móviles en iOS", transformar: { (texto) in
    return texto.uppercased()
})

print(textoTransformado)

//// MARK: Ejercicio 6
//Escribe una función filtrarNumeros que reciba un arreglo de enteros y un closure que
//indique si un número debe incluirse o no.
//Devuelve un nuevo arreglo con los números filtrados. (Implementa el ciclo for, no uses
//filter).
//⸻

func filtrarNumeros(){
    
}



//// MARK: Ejercicio 7
//Crea una función modificarArreglo que reciba un arreglo de enteros y un closure que
//transforme cada número (ejemplo: multiplicar ×2, restar 1).
//Devuelve el nuevo arreglo. (Investiga como usar map).
//⸻

func modificarArreglo(){
    
}

//// MARK: Ejercicio 8
//Escribe una función buscarElemento que reciba un arreglo de enteros, un número a
//buscar y un closure que indique la condición de igualdad.
//Devuelve true si encuentra el número, false en caso contrario.
//⸻

func buscarElemento(){
    
}

//// MARK: Ejercicio 9
//Crea una función ordenarArreglo que reciba un arreglo de enteros y un closure que
//defina el criterio de ordenamiento (ejemplo: ascendente, descendente).
//No uses sorted, implementa el algoritmo con ciclos (for / while).

func ordenarArreglo(){
    
}
