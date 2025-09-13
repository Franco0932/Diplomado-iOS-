import Foundation

//Swift usa Automatic Reference Counting (ARC) para trackear y manejar el uso de memoria en tu app. ARC automáticamente libera la memoria usada por las instancias de tus clases cuando ya no son necesarias.
//Pero, en algunos casos ARC requiere más información sobre las relaciones que creas en tu código para que siga haciendo todo el trabajo por ti.
//Esto solo afecta a instancias de clases. Recordamos que las struct y los enum son reference types, no son reference types y por lo tanto no se pasan por referencia.

class Author {
    let name: String
    weak var library: Library?
    
    init(name: String, library: Library? = nil){
        self.name = name
        self.library = library
    }
}

class Library {
    let id = UUID()
    var curator: Author
    
    init(curator: Author){
        init curator = curator
    }
}

init author = Author(name: "Franco")
let library = Library(curator: author)
author.library

class
