import UIKit
/*
// MARK: Ejercicio 1
Crea una estructura Rectangulo con propiedades ancho y alto (Double).
Agrega un método que calcule el área y otro que calcule el perímetro.
Crea un objeto y muestra ambos resultados.
⸻
*/
struct Rectangulo {
    var ancho: Double
    var alto: Double

    func area() -> Double {
        return ancho * alto
    }

    func perimetro() -> Double {
        return 2 * (ancho + alto)
    }
}

let miRectangulo = Rectangulo(ancho: 5.0, alto: 3.0)
print("Área: \(miRectangulo.area())")
print("Perímetro: \(miRectangulo.perimetro())") 

// MARK: Ejercicio 2
//Crea una estructura Alumno con propiedades nombre (String) y notas ([Int]).
//Agrega una función que devuelva la nota promedio del alumno.
//Crea un alumno y muestra su promedio.
//⸻
struct Alumno {
    var nombre: String
    var notas: [Int]

    func promedio() -> Double {
        guard !notas.isEmpty else { return 0 }
        return Double(notas.reduce(0, +)) / Double(notas.count)
    }
}

let alumno1 = Alumno(nombre: "Franco", notas: [8, 9, 10, 7])
print("Promedio de \(alumno1.nombre): \(alumno1.promedio())")

// MARK: Ejercicio 3
//Crea una estructura Inventario que tenga un diccionario de productos ([String: Int]).
//Agrega una función que devuelva el producto con mayor stock.
//⸻
struct Inventario {
    var productos: [String: Int]

    func productoMayorStock() -> String? {
        return productos.max { a, b in a.value < b.value }?.key
    }
}

let inventario = Inventario(productos: ["Manzana": 10, "Guayaba": 11 ,"Platano": 25, "Naranja": 15])
if let mayor = inventario.productoMayorStock() {
    print("Producto con mayor stock: \(mayor)")
}

// MARK: Ejercicio 4
//Crea una estructura Club con propiedad miembros: Set<String>.
//Agrega funciones para:
//1. Añadir un miembro.
//2. Eliminar un miembro.
//3. Verificar si alguien pertenece al club.
//⸻
struct club{
  var miembros: Set<String> = []
  
  mutating func agregarMiembro(_ nombre: String) {
        miembros.insert(nombre)
    }

  mutating func eliminarMiembro(_ nombre: String) {
        miembros.remove(nombre)
    }

  func perteneceAlClub(_ nombre: String) -> Bool {
        return miembros.contains(nombre)
    }
}

var verMiembros = miembros()
verMiembros.agregarMiembro("Franco")
verMiembros.agregarMiembro("Vanesa")
print("¿Vane pertenece al club?: \(verMiembros.perteneceAlClub("Vanesa"))")
verMiembros.eliminarMiembro("Franco")
print("¿Franco pertenece al club?: \(verMiembros.perteneceAlClub("Franco"))")


// MARK: Ejercicio 5
//Crea una estructura Persona con propiedades nombre (String) y edad (Int).
//Agrega una función que reciba otra persona y devuelva la persona mayor.
//⸻



// MARK: Ejercicio 6
//Crea una estructura Producto con nombre (String) y precio (Double).
//Crea un array con cinco productos y una función que devuelva el producto más caro.
//⸻


// MARK: Ejercicio 7
//Crea una estructura Curso con nombre (String) y alumnos ([String]).
//Crea un diccionario [String: Curso] y escribe una función que devuelva el curso con más
//alumnos.
//⸻
struct Curso {
    var nombre: String
    var alumnos: [Int]

    func curso() -> String {
       return alumnos.max { a, b in a.value < b.value }?.key
    }
}

let cursos = Curso(alumnos: ["MAtematicas": 35, "Ciencias": 32 ,"Historia": 25, "Deportes": 40])
if let mayor2 = cursos.cursoConMayorCant() {
    print("El curso con mayor cantidad de alumnos es: \(mayor2)")
}

// MARK: Ejercicio 8
//Crea una estructura Punto con x y y (Double).
//Agrega funciones para calcular:
//1. Distancia a otro punto.
//2. Cuadrante en que se encuentra el punto.
//⸻


// MARK: Ejercicio 9
//Crea una estructura Materia con nombre (String) y calificaciones ([Int]).
//Agrega una función que devuelva una tupla (nombre: String, promedio: Double) indicando la
//materia y su promedio.
//⸻


// MARK: Ejercicio 10
//Crea una estructura Tienda con un array de productos ([Producto]).
//Agrega funciones para:
//1. Agregar un producto.
//2. Eliminar un producto por nombre.
//3. Devolver el precio total de todos los productos.


