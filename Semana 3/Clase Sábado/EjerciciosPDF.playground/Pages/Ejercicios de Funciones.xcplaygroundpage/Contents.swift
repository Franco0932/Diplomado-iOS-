import UIKit

/*
// MARK: Ejercicio 1 – Factorial
Escribe una función factorial(_:) que reciba un número entero y devuelva su factorial.
Ejemplo: factorial(5) → 120.
⸻
*/
func factorial(factorialNumero: Int) -> Int {
    if factorialNumero == 0{
        return 1
       }else{
        return factorialNumero * factorial(factorialNumero:factorialNumero-1)
       }
    }
    var numero = 7
    var fact = factorial(factorialNumero: numero)
    print("El factorial de \(numero) es: \(fact)")
/*
// MARK: Ejercicio 2 – Números primos
Crea una función esPrimo(_:) que devuelva true si un número es primo, false si no lo es.
Después, crea otra función primosHasta(_:) que devuelva todos los números primos hasta un
límite dado.
⸻
*/
//func esPrimo(_ numeroP: Int) -> Bool {
//    if (numeroP == 0 || numeroP == 1) {
//        return false
//    }
//    let limite = Int(sqrt(Double(numeroP)))
//    for i in 2...limite {
//        if numeroP % i == 0 {
//            return false
//        }
//    }
//    return true
//}
//
//func primosHasta(_ limite: Int) -> Int {
//    var listaPrimos: [Int] = []
//    for numeroActual in stride(from: 2, through: limite, by: 1) {
//        if esPrimo(numeroActual) {
//            listaPrimos.append(numeroActual)
//        }
//    }
//    return listaPrimos
//}
//
//let limite = 20
//let numerosPrimos = primosHasta(limite) //Swift/arm64-apple-ios-simulator.swiftinterface:6140: Fatal error: Range requires lowerBound <= upperBound - error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x194c9e7a8). The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
//print("Los números primos hasta \(limite) son: \(numerosPrimos)")

/*
// MARK: Ejercicio 3 – Palíndromo con frases
Escribe una función esFrasePalindromo(_:) que reciba un texto y devuelva true si es
palíndromo, ignorando espacios y mayúsculas.
Ejemplo: "Anita lava la tina" → true.
⸻
*/
func esFrasePalindromo(_ frase: String) -> Bool {
    let filtrada = frase.lowercased().filter { caracter in
        return caracter.isLetter
    }
    return filtrada == String(filtrada.reversed())
}

let frasePrueba = "Anita lava la tina"

/*
// MARK: Ejercicio 4 – Conteo de vocales
Crea una función contarVocales(_:) que reciba un String y devuelva un diccionario con el
número de veces que aparece cada vocal (a, e, i, o, u).
⸻
*/
func contarVocales(_ texto: String) -> [Character: Int] {
    let vocales: Set<Character> = ["a", "e", "i", "o", "u"]
    var conteo: [Character: Int] = [:]
    for char in texto.lowercased() {
        if vocales.contains(char) {
            conteo[char, default: 0] += 1
        }
    }
    return conteo
}
let textoVocales = "Diplomado de Aplicaciones Moviles en iOS"
print("Conteo de vocales en '\(textoVocales)': \(contarVocales(textoVocales))")

/*
// MARK: Ejercicio 5 – Ordenar lista de números (algoritmo propio)
Escribe una función ordenarNumeros(_:) que reciba un arreglo de enteros y lo devuelva
ordenado de menor a mayor sin usar sorted().
⸻
*/
func ordenarNumeros(_ lista: [Int]) -> [Int] {
    var arr = lista
    for i in 0..<arr.count {
        for j in i+1..<arr.count {
            if arr[j] < arr[i] {
                arr.swapAt(i, j)
            }
        }
    }
    return arr
}
let desordenados = [5, 2, 9, 1, 3]
print("Lista ordenada: \(ordenarNumeros(desordenados))")

/*
// MARK: Ejercicio 6 – Fibonacci
Crea una función fibonacci(_:) que devuelva el n-ésimo número de la secuencia de Fibonacci.
Ejemplo: fibonacci(6) → 8.
⸻
*/
func fibonacci(_ n: Int) -> Int {
    if n <= 0 { return 0 }
    if n == 1 { return 1 }
    var a = 0, b = 1
    for _ in 2...n {
        let temp = a + b
        a = b
        b = temp
    }
    return b
}
print("El 6to número de Fibonacci es: \(fibonacci(6))")
 
/*
// MARK: Ejercicio 7 – Suma de dígitos
Escribe una función sumaDigitos(_:) que reciba un número entero y devuelva la suma de sus
dígitos.
Ejemplo: sumaDigitos(348) → 15.
⸻
*/
func sumaDigitos(_ numero: Int) -> Int {
    return String(numero).compactMap { Int(String($0)) }.reduce(0, +)
}
print("La suma de los dígitos de 348 es: \(sumaDigitos(348))")

/*
// MARK: Ejercicio 8 – Máximo común divisor (MCD)
Crea una función mcd(_:_:) que reciba dos enteros y devuelva su máximo común divisor
usando el algoritmo de Euclides.
⸻
*/
func mcd(_ a: Int, _ b: Int) -> Int {
    var x = a, y = b
    while y != 0 {
        let temp = y
        y = x % y
        x = temp
    }
    return x
}
print("El MCD de 48 y 18 es: \(mcd(48, 18))")

/*
// MARK: Ejercicio 9 – Número perfecto
Escribe una función esPerfecto(_:) que devuelva true si un número es perfecto.
(Un número es perfecto si la suma de sus divisores propios es igual al número. Ejemplo: 28 →
1 + 2 + 4 + 7 + 14 = 28).
⸻
*/
func esPerfecto(_ numero: Int) -> Bool {
    if numero < 2 { return false }
    var suma = 0
    for i in 1..<numero {
        if numero % i == 0 {
            suma += i
        }
    }
    return suma == numero
}
print("¿28 es un número perfecto?: \(esPerfecto(28))")

/*
// MARK: Ejercicio 10 – Conversor de bases
Crea una función convertirABase(_ numero: Int, base: Int) que convierta un número decimal a
otra base (2 = binario, 8 = octal, 16 = hexadecimal).
Ejemplo: convertirABase(10, base: 2) → "1010".
*/
func convertirABase(_ numero: Int, base: Int) -> String {
    let caracteres = Array("0123456789ABCDEF")
    var n = numero
    var resultado = ""
    repeat {
        resultado = String(caracteres[n % base]) + resultado
        n /= base
    } while n > 0
    return resultado
}
print("10 en binario: \(convertirABase(10, base: 2))")
print("10 en octal: \(convertirABase(10, base: 8))")
print("10 en hexadecimal: \(convertirABase(10, base: 16))")
