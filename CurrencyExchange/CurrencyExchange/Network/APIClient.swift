//
//  APIClient.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Alamofire

protocol APIClientProtocol {
    func asyncRequest<T: Decodable>(router: APIRouter, response: T.Type) async throws -> T
}

final class APIClient: APIClientProtocol {
    func asyncRequest<T: Decodable>(router: APIRouter, response: T.Type) async throws -> T {
        do {
            return try await AF.request(router).serializingDecodable(T.self).value
        } catch {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
}
