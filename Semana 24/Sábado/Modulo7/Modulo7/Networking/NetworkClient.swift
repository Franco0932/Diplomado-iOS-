//
//  NetworkClient.swift
//  Modulo7
//
//  Created by Franco Ruiz on 21/02/26.
//

import Foundation

final class NetworkClient: Sendable {
    
    static let shared = NetworkClient()
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    public typealias Header = (value: String, HTTPHeaderField: String)
    
    private init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        self.jsonDecoder = decoder
        self.jsonEncoder = encoder
    }
    
    func makeRequest<T: Decodable>(
        endpoint: String,
        method: RequestMethod,
        body: Data? = nil,
        additionalHeaders: [Header]? = nil
    ) async throws -> T {
        guard let url = URL(string: APIConfig.host + endpoint) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        additionalHeaders?.forEach { (value: String, HTTPHeaderField: String) in
            request.setValue(value, forHTTPHeaderField: HTTPHeaderField)
        }

        if method == .post, let body = body {
            request.httpBody = body
        }
        return try await sendRequest(request: request)
    }
    
    func sendRequest<T: Decodable>(
        request: URLRequest
    ) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw APIError.noData
            }

            switch http.statusCode {
            case 200...299:
                guard !data.isEmpty else { throw APIError.noData }
                do {
                    return try jsonDecoder.decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError(error)
                }
            case 400...499:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            case 500...599:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            default:
                throw APIError.serverError(statusCode: http.statusCode, data: data)
            }
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknow(error)
        }
    }
}
