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
func esMayorQue (_ i: Int,_ j: Int) -> Bool {
    return i > j
}

let par1 = esMayorQue(10, 5)
let par2 = esMayorQue(3, 7)
let par3 = esMayorQue(6, 90)
let par4 = esMayorQue(100, 99)


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

func procesarCadenas (){
    
}

//// MARK: Ejercicio 4
//Escribe una función compararStrings que reciba dos cadenas de texto y un closure
//que defina la comparación (por ejemplo: si son iguales, si una es más larga que la otra,
//etc.).
//El resultado debe imprimirse en consola.
//⸻
func compararStrings (cadena1: String, cadena2: String, comparacionCadenas: (String, String) -> String ) -> String {
    return comparacionCadenas(cadena1, cadena2)
}

let igual = compararStrings(cadena1: "Swift es Genial", cadena2: "Swift is Great!", comparacionCadenas: { (cadena1, cadena2) in
    return
})
//// MARK: Ejercicio 5
//Crea una función transformarTexto que reciba un String y un closure.
//El closure debe transformar el texto (ejemplo: pasarlo a mayúsculas, agregarle un
//prefijo, invertirlo).
//Devuelve el resultado.
//⸻

func tranformarTexto(){
    
}

//// MARK: Ejercicio 6
//Escribe una función filtrarNumeros que reciba un arreglo de enteros y un closure que
//indique si un número debe incluirse o no.
//Devuelve un nuevo arreglo con los números filtrados. (Implementa el ciclo for, no uses
//filter).
//⸻

func filtrarNumnero(){
    
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
