//
//  Data.swift
//  Pokedex
//
//  Created by Franco Ruiz on 28/11/25.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String
    let description: String
    let types: [String]
    let imageName: String
    let nextEvolutionId: Int?
}

struct PokeType {
    let name: String
    let imageType: String
    let doubleDamageTo: [String]
    let doubleDamageReceived: [String]
    let halfDamageDealt: [String]
    let halfDamageReceived: [String]
    let notAffectedBy: [String]
    let noEffectAgainst: [String]
}

class DataRepository {
    static let shared = DataRepository()
    
    let allPokemon: [Pokemon] = [
        //1er pokemon
        Pokemon(id: 1, name: "Bulbasaur", description: "Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.", types: ["Planta", "Veneno"], imageName: "bulbasaur", nextEvolutionId: 2),
        Pokemon(id: 2, name: "Ivysaur", description: "Cuanta más luz solar recibe, más aumenta su fuerza y más se desarrolla el capullo que tiene en el lomo.", types: ["Planta", "Veneno"], imageName: "ivysaur", nextEvolutionId: 3),
        Pokemon(id: 3, name: "Venusaur", description: "Puede convertir la luz del sol en energía. Por esa razón, es más poderoso en verano.", types: ["Planta", "Veneno"], imageName: "venusaur", nextEvolutionId: nil),
        
        //2 pokemon
        Pokemon(id: 4, name: "Charmander", description: "La llama de su cola indica su fuerza vital. Si está débil, la llama arderá más tenue.", types: ["Fuego"], imageName: "charmander", nextEvolutionId: 5),
        Pokemon(id: 5, name: "Charmeleon", description: "Al agitar su ardiente cola, eleva poco a poco la temperatura a su alrededor para sofocar a sus rivales.", types: ["Fuego"], imageName: "charmeleon", nextEvolutionId: 6),
        Pokemon(id: 6, name: "Charizard", description: "Cuando se enfurece de verdad, la llama de la punta de su cola se vuelve de color azul claro.", types: ["Fuego"], imageName: "charizard", nextEvolutionId: nil),
        
        //3er pokemon
        Pokemon(id: 7, name: "Squirtle", description: "Tras nacer, se le hincha el lomo y se le forma un caparazón. Escupe poderosa espuma por la boca.", types: ["Agua"], imageName: "squirtle", nextEvolutionId: 8),
        Pokemon(id: 8, name: "Wartortle", description: "Tiene una cola larga y peluda que simboliza la longevidad y lo hace popular entre los mayores.", types: ["Agua"], imageName: "wartortle", nextEvolutionId: 9),
        Pokemon(id: 9, name: "Blastoise", description: "Aumenta de peso deliberadamente para contrarrestar la fuerza de los chorros de agua que dispara.", types: ["Agua"], imageName: "blastoise", nextEvolutionId: nil),
        
        //4to pokemon
        Pokemon(id: 66, name: "Machop", description: "Es una masa de músculos y, pese a su pequeño tamaño, tiene fuerza de sobra para levantar en brazos a 100 personas.", types: ["Lucha"], imageName: "machop", nextEvolutionId: 67),
        Pokemon(id: 67, name: "Machoke", description: "Su musculoso cuerpo es tan fuerte que usa un cinto antifuerza para controlar sus movimientos.", types: ["Lucha"], imageName: "machoke", nextEvolutionId: 68),
        Pokemon(id: 68, name: "Machamp", description: "Mueve sus cuatro brazos a tal velocidad que resultan imposibles de ver. Puede asestar hasta mil puñetazos en dos segundos.", types: ["Lucha"], imageName: "machamp", nextEvolutionId: nil),
        
        //5to pokemon
        Pokemon(id: 92, name: "Gastly", description: "Su estrategia consiste en envolver al rival con su cuerpo gaseoso y envenenarlo a través de la piel.", types: ["Fantasma", "Veneno"], imageName: "gastly", nextEvolutionId: 93),
        Pokemon(id: 93, name: "Haunter", description: "Tiene una cola larga y peluda que simboliza la longevidad y lo hace popular entre los mayores.", types: ["Fantasma", "Veneno"], imageName: "haunter", nextEvolutionId: 94),
        Pokemon(id: 94, name: "Gengar", description: "Para quitarle la vida a su presa, se desliza en su sombra y espera su oportunidad en silencio.", types: ["Fantasma", "Veneno"], imageName: "gengar", nextEvolutionId: nil),
        
        //6to pokemon
        Pokemon(id: 147, name: "Dratini", description: "Durante la etapa de crecimiento, muda muchas veces de piel y se protege mediante una cascada.", types: ["Dragon"], imageName: "dratini", nextEvolutionId: 148),
        Pokemon(id: 148, name: "Dragonair", description: "Dicen que, cuando su cuerpo desprende un aura, el tiempo empieza a cambiar inmediatamente.", types: ["Dragon"], imageName: "dragonair", nextEvolutionId: 149),
        Pokemon(id: 149, name: "Dragonite", description: "Dicen que viven en una isla en algún lugar del océano que solo ellos habitan.", types: ["Dragon", "Volador"], imageName: "dragonite", nextEvolutionId: nil),
        
    ]
    
    let allTypes: [PokeType] = [
            PokeType(name: "Acero", imageType: "Icon_Acero",
                     doubleDamageTo: ["Hada", "Hielo", "Roca"],
                     doubleDamageReceived: ["Fuego", "Lucha", "Tierra"],
                     halfDamageDealt: ["Acero", "Agua", "Electrico", "Fuego"],
                     halfDamageReceived: ["Acero", "Bicho", "Dragon", "Hada", "Hielo", "Normal", "Planta", "Psiquico", "Roca", "Volador"],
                     notAffectedBy: ["Veneno"],
                     noEffectAgainst: []),
            
            PokeType(name: "Agua", imageType: "Icon_Agua",
                     doubleDamageTo: ["Fuego", "Roca", "Tierra"],
                     doubleDamageReceived: ["Electrico", "Planta"],
                     halfDamageDealt: ["Agua", "Dragon", "Planta"],
                     halfDamageReceived: ["Acero", "Agua", "Fuego", "Hielo"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Bicho", imageType: "Icon_Bicho",
                     doubleDamageTo: ["Planta", "Psiquico", "Siniestro"],
                     doubleDamageReceived: ["Fuego", "Roca", "Volador"],
                     halfDamageDealt: ["Acero", "Fantasmas", "Fuego", "Hada", "Lucha", "Veneno", "Volador"],
                     halfDamageReceived: ["Lucha", "Planta", "Tierra"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Dragon", imageType: "Icon_Dragon",
                     doubleDamageTo: ["Dragon"],
                     doubleDamageReceived: ["Dragon", "Hada", "Hielo"],
                     halfDamageDealt: ["Acero"],
                     halfDamageReceived: ["Agua", "Electrico", "Fuego", "Planta"],
                     notAffectedBy: [],
                     noEffectAgainst: ["Hada"]),
            
            PokeType(name: "Electrico", imageType: "Icon_Electrico",
                     doubleDamageTo: ["Agua", "Volador"],
                     doubleDamageReceived: ["Tierra"],
                     halfDamageDealt: ["Dragon", "Electrico", "Planta"],
                     halfDamageReceived: ["Acero", "Electrico", "Volador"],
                     notAffectedBy: [],
                     noEffectAgainst: ["Tierra"]),
            
            PokeType(name: "Fantasma", imageType: "Icon_Fantasma",
                     doubleDamageTo: ["Fantasma", "Psiquico"],
                     doubleDamageReceived: ["Fantasma", "Siniestro"],
                     halfDamageDealt: ["Siniestro"],
                     halfDamageReceived: ["Bicho", "Veneno"],
                     notAffectedBy: ["Lucha", "Normal"],
                     noEffectAgainst: ["Normal"]),
            
            PokeType(name: "Fuego", imageType: "Icon_Fuego",
                     doubleDamageTo: ["Acero", "Bicho", "Hielo", "Planta"],
                     doubleDamageReceived: ["Agua", "Roca", "Tierra"],
                     halfDamageDealt: ["Agua", "Dragon", "Fuego", "Roca"],
                     halfDamageReceived: ["Acero", "Bicho", "Fuego", "Hada", "Hielo", "Planta"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Hada", imageType: "Icon_Hada",
                     doubleDamageTo: ["Dragon", "Lucha", "Siniestro"],
                     doubleDamageReceived: ["Acero", "Veneno"],
                     halfDamageDealt: ["Acero", "Fuego", "Veneno"],
                     halfDamageReceived: ["Bicho", "Lucha", "Siniestro"],
                     notAffectedBy: ["Dragon"],
                     noEffectAgainst: []),
            
            PokeType(name: "Hielo", imageType: "Icon_Hielo",
                     doubleDamageTo: ["Dragon", "Planta", "Tierra", "Volador"],
                     doubleDamageReceived: ["Acero", "Fuego", "Lucha", "Roca"],
                     halfDamageDealt: ["Acero", "Agua", "Fuego", "Hielo"],
                     halfDamageReceived: ["Hielo"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Lucha", imageType: "Icon_Lucha",
                     doubleDamageTo: ["Acero", "Hielo", "Normal", "Roca", "Siniestro"],
                     doubleDamageReceived: ["Hada", "Psiquico", "Volador"],
                     halfDamageDealt: ["Bicho", "Hada", "Psiquico", "Veneno", "Volador"],
                     halfDamageReceived: ["Bicho", "Roca", "Siniestro"],
                     notAffectedBy: [],
                     noEffectAgainst: ["Fantasma"]),
            
            PokeType(name: "Normal", imageType: "Icon_Normal",
                     doubleDamageTo: [],
                     doubleDamageReceived: ["Lucha"],
                     halfDamageDealt: ["Acero", "Roca"],
                     halfDamageReceived: [],
                     notAffectedBy: ["Fantasma"],
                     noEffectAgainst: ["Fantasma"]),
            
            PokeType(name: "Planta", imageType: "Icon_Planta",
                     doubleDamageTo: ["Agua", "Roca", "Tierra"],
                     doubleDamageReceived: ["Bicho", "Fuego", "Hielo", "Veneno", "Volador"],
                     halfDamageDealt: ["Acero", "Bicho", "Dragon", "Fuego", "Planta", "Veneno", "Volador"],
                     halfDamageReceived: ["Agua", "Electrico", "Planta", "Tierra"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Psiquico", imageType: "Icon_Psiquico",
                     doubleDamageTo: ["Lucha", "Veneno"],
                     doubleDamageReceived: ["Bicho", "Fantasma", "Siniestro"],
                     halfDamageDealt: ["Acero", "Psiquico"],
                     halfDamageReceived: ["Lucha", "Psiquico"],
                     notAffectedBy: [],
                     noEffectAgainst: ["Siniestro"]),
            
            PokeType(name: "Roca", imageType: "Icon_Roca",
                     doubleDamageTo: ["Bicho", "Fuego", "Hielo", "Volador"],
                     doubleDamageReceived: ["Acero", "Agua", "Lucha", "Planta", "Tierra"],
                     halfDamageDealt: ["Acero", "Lucha", "Tierra"],
                     halfDamageReceived: ["Fuego", "Normal", "Veneno", "Volador"],
                     notAffectedBy: [],
                     noEffectAgainst: []),
            
            PokeType(name: "Siniestro", imageType: "Icon_Siniestro",
                     doubleDamageTo: ["Fantasma", "Psiquico"],
                     doubleDamageReceived: ["Bicho", "Hada", "Lucha"],
                     halfDamageDealt: ["Hada", "Lucha", "Siniestro"],
                     halfDamageReceived: ["Fantasma", "Siniestro"],
                     notAffectedBy: ["Psiquico"],
                     noEffectAgainst: []),
            
            PokeType(name: "Tierra", imageType: "Icon_Tierra",
                     doubleDamageTo: ["Acero", "Electrico", "Fuego", "Roca", "Veneno"],
                     doubleDamageReceived: ["Agua", "Hielo", "Planta"],
                     halfDamageDealt: ["Bicho", "Planta"],
                     halfDamageReceived: ["Roca", "Veneno"],
                     notAffectedBy: ["Electrico"],
                     noEffectAgainst: ["Volador"]),
            
            PokeType(name: "Veneno", imageType: "Icon_Veneno",
                     doubleDamageTo: ["Hada", "Planta"],
                     doubleDamageReceived: ["Psiquico", "Tierra"],
                     halfDamageDealt: ["Fantasma", "Roca", "Tierra", "Veneno"],
                     halfDamageReceived: ["Bicho", "Hada", "Lucha", "Planta", "Veneno"],
                     notAffectedBy: [],
                     noEffectAgainst: ["Acero"]),
            
            PokeType(name: "Volador", imageType: "Icon_Volador",
                     doubleDamageTo: ["Bicho", "Lucha", "Planta"],
                     doubleDamageReceived: ["Electrico", "Hielo", "Roca"],
                     halfDamageDealt: ["Acero", "Electrico", "Roca"],
                     halfDamageReceived: ["Bicho", "Lucha", "Planta"],
                     notAffectedBy: ["Tierra"],
                     noEffectAgainst: [])
        ]
    
    private let favKey = "fav_pokemons"
    
    func isFavorite(id: Int) -> Bool {
        let saved = UserDefaults.standard.array(forKey: favKey) as? [Int] ?? []
        return saved.contains(id)
    }
    
    func toggleFavorite(id: Int) {
        var saved = UserDefaults.standard.array(forKey: favKey) as? [Int] ?? []
        if saved.contains(id) {
            saved.removeAll { $0 == id }
        } else {
            saved.append(id)
        }
        UserDefaults.standard.set(saved, forKey: favKey)
    }
    
    func getFavoritePokemons() -> [Pokemon] {
        let savedIds = UserDefaults.standard.array(forKey: favKey) as? [Int] ?? []
        return allPokemon.filter { savedIds.contains($0.id) }
    }
    func getEvolutionChain(for pokemonId: Int) -> [Pokemon] {
        var chain: [Pokemon] = []
        var currentId = pokemonId
        var firstId = pokemonId
        
        while let previousPoke = allPokemon.first(where: { $0.nextEvolutionId == currentId }) {
            currentId = previousPoke.id
            firstId = previousPoke.id
        }
        
        if let firstPoke = allPokemon.first(where: { $0.id == firstId }) {
            chain.append(firstPoke)
            var nextEvoId = firstPoke.nextEvolutionId
            while let nextId = nextEvoId,
                  let nextPoke = allPokemon.first(where: { $0.id == nextId }) {
                chain.append(nextPoke)
                nextEvoId = nextPoke.nextEvolutionId
            }
        }
        
        return chain
    }
}

extension DataRepository {
    func getIconName(for typeName: String) -> String? {
        return allTypes.first(where: { $0.name == typeName })?.imageType
    }
}
