//
//  NetworkManager.swift
//  CatAPI
//
//  Created by jinwoong Kim on 2023/09/21.
//

import Foundation

protocol NetworkManager {
    func parseText(animal animalType: String, amount: Int, method: HTTPMethod) async throws -> [CatFact]
}

final class DefaultNetworkManager: NetworkManager {
    private let baseURI = URL(string: "https://cat-fact.herokuapp.com")
    
    func parseText(
        animal animalType: String = "cat",
        amount: Int = 2,
        method: HTTPMethod = .GET
    ) async throws -> [CatFact] {
        let url = try buildURL(
            with: [
                "animal_type": animalType,
                "amount": "\(amount)"
            ]
        )
        let request = try buildRequest(with: url, method: method)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw FactError.networkError
        }
        
        let facts: [CatFact] = try decode(data: data)
        
        return facts
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let data = try decoder.decode(T.self, from: data)
        
        return data
    }

    private func buildURL(with query: [String: String]) throws -> URL {
        guard var url = baseURI else { throw FactError.noURL }
        
        let queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        url.append(path: "facts/random")
        url.append(queryItems: queryItems)
        
        return url
    }
    
    private func buildRequest(with url: URL, method: HTTPMethod, body: Data? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
}
