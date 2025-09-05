import Foundation

//MARK: For
let  caracteres = ["Sam", "Dean", "Jack", "Jody","Bobby", "Castiel", "Garth"]

for caractere in caracteres {
    print(caractere + " es un personaje de una serie llamada Supernatural")
}

let pokemonList = ["Fire": "Charmander", "Water": "Mudkip", "Grass": "Turrwig", "Electric": "Pikachu"]
for pokemon in pokemonList {
    print(pokemon.value + " es de tipo " + pokemon.key)
}

//for (name, type) is pokemonList {
//    print(name + " es de tipo " type)
//}

let numbers = 1...10
for number in numbers where number % 2 == 0{
    print(number)
}

for _ in numbers {
    print("hello!")
}

