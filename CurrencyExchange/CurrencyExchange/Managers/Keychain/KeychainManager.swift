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
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let swopKey = "4876bcfc9e8006f64b0ba6b561e0a88539fe173b6d9039783abf0ab2e76020cf"
    
    private init() {
        keychainSwift.set(swopKey, forKey: Keys.apiKey.rawValue)
    }
    
    func retrieveSwopKey() -> String? {
        guard let swopKey = keychainSwift.get(Keys.apiKey.rawValue) else {
            return nil
        }
        
        return swopKey
    }
    
    func storeRates(_ rates: [CurrencyRateModel]) async {
        if let encodedData = try? encoder.encode(rates) {
            keychainSwift.set(encodedData, forKey: Keys.rates.rawValue)
        } else {
            debugPrint("Encode data failed")
        }
    }
    
    func retrieveRates() async -> [CurrencyRateModel] {
        if let result = keychainSwift.getData(Keys.rates.rawValue) {
            do {
                let decodedData = try decoder.decode([CurrencyRateModel].self, from: result)
                return decodedData
            } catch {
                debugPrint("Decode data failed")
            }
        }
        
        return []
    }
}

extension KeychainManager {
    private enum Keys: String {
        case apiKey = "API_KEY"
        case rates = "RATES_KEY"
    }
}
