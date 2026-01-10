//
//  ColoursLocalRepository.swift
//  AppModulo
//
//  Created by Franco Ruiz on 29/11/25.
//

protocol ColoursRepository{
    func getColoursList(for user: String) throws -> [ColoursDTO]
}

struct ColoursLocalRepository: ColoursRepository {
    func getColoursList(for user: String) throws -> [ColoursDTO] {
        guard let url = Bundle.main.url(forResource: "Colours", withExtension: ".json") else { return nil}
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([UserDTO].self, from: data)
    }
}
