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
func esPrimo(_ numeroP: Int) -> Bool {
    if (numeroP == 0 || numeroP == 1) {
        return false
    }
    for i in 2...Int(sqrt(Double(numeroP))) {
        if numeroP % i == 0 {
            return false
        }
    }
    return true
}

func primosHasta(_ limite: Int) -> [Int] {
    return (2...limite).filter {
        esPrimo($0)
    }
}

print("Primos hasta 10:", primosHasta(10))

/*
// MARK: Ejercicio 3 – Palíndromo con frases
Escribe una función esFrasePalindromo(_:) que reciba un texto y devuelva true si es
palíndromo, ignorando espacios y mayúsculas.
Ejemplo: "Anita lava la tina" → true.
⸻
*/
func esFrasePalindromo(){
    
}

/*
// MARK: Ejercicio 4 – Conteo de vocales
Crea una función contarVocales(_:) que reciba un String y devuelva un diccionario con el
número de veces que aparece cada vocal (a, e, i, o, u).
⸻
*/
func contarVocales(){
    
}

/*
// MARK: Ejercicio 5 – Ordenar lista de números (algoritmo propio)
Escribe una función ordenarNumeros(_:) que reciba un arreglo de enteros y lo devuelva
ordenado de menor a mayor sin usar sorted().
⸻
*/
func ordenarNumeros(){
    
}

/*
// MARK: Ejercicio 6 – Fibonacci
Crea una función fibonacci(_:) que devuelva el n-ésimo número de la secuencia de Fibonacci.
Ejemplo: fibonacci(6) → 8.
⸻
*/
func fibonacci(){
    
}
 
/*
// MARK: Ejercicio 7 – Suma de dígitos
Escribe una función sumaDigitos(_:) que reciba un número entero y devuelva la suma de sus
dígitos.
Ejemplo: sumaDigitos(348) → 15.
⸻
*/
func sumaDigitos(){
    
}

/*
// MARK: Ejercicio 8 – Máximo común divisor (MCD)
Crea una función mcd(_:_:) que reciba dos enteros y devuelva su máximo común divisor
usando el algoritmo de Euclides.
⸻
*/
func mcd(){
    
}

/*
// MARK: Ejercicio 9 – Número perfecto
Escribe una función esPerfecto(_:) que devuelva true si un número es perfecto.
(Un número es perfecto si la suma de sus divisores propios es igual al número. Ejemplo: 28 →
1 + 2 + 4 + 7 + 14 = 28).
⸻
*/
func esPerfecto(){
    
}

/*
// MARK: Ejercicio 10 – Conversor de bases
Crea una función convertirABase(_ numero: Int, base: Int) que convierta un número decimal a
otra base (2 = binario, 8 = octal, 16 = hexadecimal).
Ejemplo: convertirABase(10, base: 2) → "1010".
*/
func convertirABase(){
    
}
