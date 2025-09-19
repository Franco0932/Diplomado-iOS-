import UIKit

//MARK: Ejercicio 1 – Clase Persona
//Crea una clase Persona con propiedades nombre y edad.
//Agrega un método presentarse() que imprima: "Hola, me llamo NOMBRE y tengo EDAD años."
//Crea 2 instancias y llama al método en ambas.
//⸻

class Persona {
    var nombre: String
    var edad: Int

    init(nombre: String, edad: Int) {
        self.nombre = nombre
        self.edad = edad
    }

    func presentarse() {
        print("Hola, me llamo \(nombre) y tengo \(edad) años.")
    }
}

let persona1 = Persona(nombre: "Franco", edad: 24)
let persona2 = Persona(nombre: "Vane", edad: 24)

persona1.presentarse()
persona2.presentarse()

//// MARK: Ejercicio 2 – Clase Coche con Enum
//Crea una clase Coche con propiedades marca y modelo.
//Define un enum EstadoCoche con valores .encendido, .apagado.
//Agrega métodos encender() y apagar() que cambien el estado e impriman un mensaje.
//⸻
enum EstadoCoche {
    case encendido
    case apagado
}

class Coche {
    let marca : String
    let modelo : String
    
    init(marca: String, modelo: String) {
        self.marca = marca
        self.modelo = modelo
    }
    func encender() {
        print("El coche \(marca) \(modelo) está encendido")
    }
    func apagar() {
        print("El coche \(marca) \(modelo) está apagado")
    }
}

let coche1 = Coche(marca: "Ford", modelo: "Fiesta")
coche1.encender()
coche1.apagar() 
let coche2 = Coche(marca: "Chevrolet", modelo: "Onix")
coche2.encender()
coche2.apagar()

//// MARK: Ejercicio 3 – Inventario de Productos
//Crea una clase Producto con propiedades nombre y precio.
//Crea una clase Inventario que guarde un arreglo de productos y tenga un método
//productoMasCaro() que devuelva el producto más caro.
//⸻

class Producto {
    var nombre: String
    var precio: Double

    init(nombre: String, precio: Double) {
        self.nombre = nombre
        self.precio = precio
    }
}

class Inventario {
    var productos: [Producto] = []

    func agregarProducto(_ producto: Producto) {
        productos.append(producto)
    }

    func productoMasCaro() -> Producto? {
        return productos.max(by: { $0.precio < $1.precio })
    }
}

let inventario = Inventario()
let producto1 = Producto(nombre: "Laptop", precio: 1500.0)
let producto2 = Producto(nombre: "Smartphone", precio: 800.0)
let producto3 = Producto(nombre: "Tablet", precio: 600.0)


//// MARK: Ejercicio 4 – Clase Estudiante con Calificaciones
//Crea una clase Estudiante con propiedades nombre y calificaciones: [Int].
//Agrega un método promedio() que devuelva el promedio de las calificaciones.
//Prueba con al menos 2 estudiantes.
//⸻

class Estudiante {
    var nombre: String
    var calificaciones: Int

    init(nombre: String, calificaciones: Int) {
        self.nombre = nombre
        self.calificaciones = calificaciones
    }

    func promedio() {
        print("Alumno: \(nombre), promedio de calificaciones: \(calificaciones)")
    }
}

let estudiante1 = Estudiante(nombre: "Franco", calificaciones: 9)
let estudiante2 = Estudiante(nombre: "Vane", calificaciones: 10)
estudiante1.promedio()
estudiante2.promedio()


//// MARK: Ejercicio 5 – Enum Días de la Semana
//Declara un enum DiaSemana con los casos: lunes a domingo.
//Crea una clase Agenda con un diccionario [DiaSemana: String] para asignar actividades.
//Agrega un método mostrarActividad(dia:) que devuelva la actividad del día recibido.
//⸻
enum DiaSemana: String {
    case lunes = "Lunes"
    case martes = "Martes"
    case miercoles = "Miércoles"
    case jueves = "Jueves"
    case viernes = "Viernes"
    case sabado = "Sábado"
    case domingo = "Domingo"
}

class Agenda {
    var actividades: [DiaSemana: String] = [:]

    func asignarActividad(dia: DiaSemana, actividad: String) {
        actividades[dia] = actividad
    }

    func mostrarActividad(dia: DiaSemana) -> String {
        return actividades[dia] ?? "No hay actividad asignada para \(dia.rawValue)"
    }
}

let agenda = Agenda()
agenda.asignarActividad(dia: .lunes, actividad: "Reunión de trabajo")
agenda.asignarActividad(dia: .miercoles, actividad: "Clase de CGEIH")
print(agenda.mostrarActividad(dia: .lunes))
print(agenda.mostrarActividad(dia: .martes))
print(agenda.mostrarActividad(dia: .miercoles)) 


//// MARK: Ejercicio 6 – Clase CuentaBancaria
//Crea una clase CuentaBancaria con propiedades titular y saldo.
//Agrega métodos depositar(monto:) y retirar(monto:).
//Valida que no se pueda retirar más de lo que hay en la cuenta.
//⸻

class CuentaBancaria {
    var titular: String
    var saldo: Double

    init(titular: String, saldo: Double) {
        self.titular = titular
        self.saldo = saldo
    }

    func depositar(monto: Double) {
        saldo += monto
        print("Depósito de \(monto). Nuevo saldo: \(saldo)")
    }

    func retirar(monto: Double) {
        if monto > saldo {
            print("Fondos insuficientes. Saldo actual: \(saldo)")
        } else {
            saldo -= monto
            print("Retiro de \(monto). Nuevo saldo: \(saldo)")
        }
    }
}

let cuenta = CuentaBancaria(titular: "Franco", saldo: 1000.0)
cuenta.depositar(monto: 500.0)
cuenta.retirar(monto: 200.0)
cuenta.retirar(monto: 2000.0)

//// MARK: Ejercicio 7 – Juego con Enum
//Crea un enum Movimiento con casos .arriba, .abajo, .izquierda, .derecha.
//Crea una clase Jugador con propiedades nombre y posicion: (x: Int, y: Int).
//Agrega un método mover(_:) que cambie la posición según el movimiento.
//⸻

enum Movimiento {
    case arriba
    case abajo
    case izquierda
    case derecha
}

class Jugador {
    var nombre: String
    var posicion: (x: Int, y: Int)

    init(nombre: String, posicion: (x: Int, y: Int)) {
        self.nombre = nombre
        self.posicion = posicion
    }

    func mover(_ movimiento: Movimiento) {
        switch movimiento {
        case .arriba:
            posicion.y += 1
        case .abajo:
            posicion.y -= 1
        case .izquierda:
            posicion.x -= 1
        case .derecha:
            posicion.x += 1
        }
        print("\(nombre) se movió a la posición (\(posicion.x), \(posicion.y))")
    }
}

let jugador = Jugador(nombre: "Franco", posicion: (0, 0))
jugador.mover(.arriba)
jugador.mover(.derecha)
jugador.mover(.abajo)
jugador.mover(.izquierda)

//// MARK: Ejercicio 8 – Biblioteca con Clases
//Crea una clase Libro con propiedades titulo y autor.
//Crea una clase Biblioteca con un arreglo de libros y un método buscarPorAutor(_:) que
//devuelva todos los libros de un autor específico.
//⸻

class Libro {
    var titulo: String
    var autor: String

    init(titulo: String, autor: String) {
        self.titulo = titulo
        self.autor = autor
    }
}

class Biblioteca {
    var libros: [Libro] = []

    func agregarLibro(_ libro: Libro) {
        libros.append(libro)
    }

    func buscarPorAutor(_ autor: String) -> [Libro] {
        return libros.filter { $0.autor == $1.autor }
    }
}

let biblioteca = Biblioteca()
let libro1 = Libro(titulo: "", autor: "")
let libro2 = Libro(titulo: "", autor: "")
let libro3 = Libro(titulo: "", autor: "")
biblioteca.agregarLibro(libro1)
biblioteca.agregarLibro(libro2)
biblioteca.agregarLibro(libro3) 

//// MARK: Ejercicio 9 – Enum Nivel y Clase VideoJuego
//Declara un enum Nivel con casos .facil, .medio, .dificil.
//Crea una clase VideoJuego con propiedades titulo y nivel.
//Agrega un método descripcion() que imprima "El juego TITULO está en nivel NIVEL".
//⸻
enum Nivel {
    case facil
    case medio
    case dificil
}

class VideoJuego {
    var titulo: String
    var nivel: Nivel

    init(titulo: String, nivel: Nivel) {
        self.titulo = titulo
        self.nivel = nivel
    }

    func descripcion() {
        print("El juego \(titulo) está en nivel \(nivel)")
    }
}

let juego1 = VideoJuego(titulo: "Elden Ring", nivel: .dificil)
juego1.descripcion()
let juego2 = VideoJuego(titulo: "Mario Bros", nivel: .medio)
juego2.descripcion()
let juego3 = VideoJuego(titulo: "Pou", nivel: .facil)
juego3.descripcion()

//// MARK: Ejercicio 10 – Clase Restaurante
//Crea una clase Platillo con propiedades nombre y precio.
//Crea una clase Restaurante con una lista de platillos y un método ordenarPlatillo(nombre:) que
//busque el platillo e imprima su precio.
//Si no existe, imprime "No tenemos ese platillo."

class Platillo {
    var nombre: String
    var precio: Double

    init(nombre: String, precio: Double) {
        self.nombre = nombre
        self.precio = precio
    }
}

class Restaurante {
    var menu: [Platillo] = []

    func agregarPlatillo(_ platillo: Platillo) {
        menu.append(platillo)
    }

    func ordenarPlatillo(nombre: String) {
        if let platillo = menu.first(where: { $0.nombre == nombre }) {
            print("El precio de \(nombre) es \(platillo.precio)")
        } else {
            print("No tenemos ese platillo.")
        }
    }
}

let restaurante = Restaurante()
let platillo1 = Platillo(nombre: "Pizza", precio: 12.0)
let platillo2 = Platillo(nombre: "Pasta", precio: 10.0)
restaurante.agregarPlatillo(platillo1)
restaurante.agregarPlatillo(platillo2)
restaurante.ordenarPlatillo(nombre: "Pizza")
restaurante.ordenarPlatillo(nombre: "Ensalada")     
