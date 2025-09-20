import UIKit

//MARK: Protocolos
//Permiten hacer encapsulamientos en swift y permiten proporcionar metodos
//Un protocolo define un esquema de métodos, propiedades y otros requisitos que se adaptan a una tarea o
//funcionalidad específica. Posteriormente, una clase, estructura o enumeración puede adoptar el protocolo
//para proporcionar una implementación real de dichos requisitos. Cualquier tipo que cumpla los requisitos
//de un protocolo se considera conforme a él.

//Además de especificar los requisitos que deben implementar los tipos conformes, puede ampliar un protocolo
//para implementar algunos de estos requisitos o para implementar una funcionalidad adicional que los tipos
//conformes puedan aprovechar.

//Cuando un tipo de dato satiface a todo el protocolo se dice que lo conforma.

//Ejemplo
let data = [
    ["Eva", "30", "6"],
    ["Salem", "40", "18"],
    ["Andres", "50", "20"]
]

func printTable(_ data: [String]){
    for row in data {
        var output = "|"
        
        for item in row {
            output += "\(item) |"
        }
        print(output)
    }
}

