//
//  KeychainManager.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation
import KeychainSwift

final class KeychainManager {
    static let shared = KeychainManager()
    
    private let keychainSwift = KeychainSwift()
    private let swopKey = "4876bcfc9e8006f64b0ba6b561e0a88539fe173b6d9039783abf0ab2e76020cf"
    private let apiKey = "API_KEY"
    
    private init() {
        keychainSwift.set(swopKey, forKey: apiKey)
    }
    
    func retrieveSwopKey() -> String? {
        guard let swopKey = keychainSwift.get(apiKey) else {
            return nil
        }
        
        return swopKey
    }
}
