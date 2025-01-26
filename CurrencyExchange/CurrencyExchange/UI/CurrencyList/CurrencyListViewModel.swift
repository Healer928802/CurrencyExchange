//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

final class CurrencyListViewModel {
    private let apiClient: APIClientProtocol
    let keychainManager: KeychainManager
    
    var currencyRates: [CurrencyRateTransformed] = []
    var favoriteCurrencyRates: [CurrencyRateTransformed] = []
    
    weak var delegate: ReloadDataProtocol?
    
    init(apiClient: APIClientProtocol, keychainManager: KeychainManager) {
        self.apiClient = apiClient
        self.keychainManager = keychainManager
    }
    
    func loadCurrencyRates() {
        Task {
            do {
                let result = try await apiClient.asyncRequest(router: APIRouter.rates, response: [CurrencyRateModel].self)
                
                favoriteCurrencyRates = await keychainManager.retrieveFavoriteRates()
                
                currencyRates = result.map { value in
                    let isFavorite = favoriteCurrencyRates.contains(where: {
                        $0.baseCurrency == value.baseCurrency && $0.quoteCurrency == value.quoteCurrency
                    })
                    
                    return CurrencyRateTransformed(
                        baseCurrency: value.baseCurrency,
                        quoteCurrency: value.quoteCurrency,
                        quote: "\(value.quote)",
                        date: value.date,
                        isSelected: isFavorite
                    )
                }
                
                keychainManager.storeRates(currencyRates, with: .rates)
                
                await MainActor.run {
                    delegate?.reloadData(with: .success)
                }
            } catch {
                currencyRates = await keychainManager.retrieveRates()
                
                await MainActor.run {
                    currencyRates.isEmpty ? delegate?.reloadData(with: .noRatesStored) : delegate?.reloadData(with: .noConnection)
                }
            }
        }
    }
    
    func updateFavorites() {
        Task {
            favoriteCurrencyRates = await keychainManager.retrieveFavoriteRates()
        }
    }
}
