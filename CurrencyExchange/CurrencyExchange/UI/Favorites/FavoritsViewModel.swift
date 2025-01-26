//
//  FavoritsViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 26.01.2025.
//

import Foundation

final class FavoritsViewModel {
    let keychainManager: KeychainManager
    
    var favoriteRates: [CurrencyRateTransformed] = []
    var currencyRates: [CurrencyRateTransformed]
    
    weak var delegate: ReloadDataProtocol?
    
    init(keychainManager: KeychainManager, currencyRates: [CurrencyRateTransformed]) {
        self.keychainManager = keychainManager
        self.currencyRates = currencyRates
    }
    
    func retrieveFavorites() {
        Task {
            favoriteRates = await keychainManager.retrieveFavoriteRates()
            
            await MainActor.run {
                favoriteRates.isEmpty ? delegate?.reloadData(with: .noFavorites) : delegate?.reloadData(with: .success)
            }
        }
    }
}
