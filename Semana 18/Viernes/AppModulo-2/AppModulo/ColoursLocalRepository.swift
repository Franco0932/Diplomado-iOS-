//
//  ColoursLocalRepository.swift
//  AppModulo
//
//  Created by Yibriam on 29/11/25.
//

import Foundation

protocol ColoursRepository {
    func getColourList(for user: String) async throws -> [ColourDTO]?
    func getColourList(for user: String, handler: @escaping (Result<[ColourDTO]?, Error>) -> Void)
}

struct ColoursLocalRepository: ColoursRepository {
    func getColourList(for user: String, handler: @escaping (Result<[ColourDTO]?, any Error>) -> Void) {
        let url = Bundle.main.url(forResource: "Colours", withExtension: ".json")!
        do {
            let data = try Data(contentsOf: url)
            let colours = try JSONDecoder().decode([ColourDTO].self, from: data)
            handler(.success(colours))
        } catch  {
            handler(.failure(error))
        }
    }
}
    
struct ColourRemoteRepository: ColoursRepository {
    func getColourList(for user: String) async throws -> [ColourDTO]? {
//        guard let url = Bundle.main.url(forResource: "Colours", withExtension: ".json") else { return nil }
//        let data = try Data(contentsOf: url)
//        return try JSONDecoder().decode([ColourDTO].self, from: data)
        let endpoint = Endpoint.photos([.init(name: "email", value: "Shanna@melissa.tv"),
                                        .init(name: "_limit", value: "10"),
                                        .init(name: "_start", value: "0"),
                                        ])
        return try await URLRequestHelper.basicNetworkCall(endpoint: endpoint)

    }

    func getColourList(for user: String, handler: @escaping (Result<[ColourDTO]?, any Error>) -> Void {
        let endpoint = Endpoint.photos([.init(name: "email", value: "Shanna@melissa.tv"),
                                        .init(name: "_limit", value: "10"),
                                        .init(name: "_start", value: "0"),
                                        ])
        URLRequestHelper.basicNetworkCall(endpoint: endpoint, handler: handler)
    }
}
