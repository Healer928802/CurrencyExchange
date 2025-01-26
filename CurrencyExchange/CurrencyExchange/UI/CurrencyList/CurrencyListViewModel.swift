//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

final class CurrencyListViewModel {
    private let apiClient: APIClientProtocol
    private let keychainManager: KeychainManager
    
    private(set) var currencyRates: [CurrencyRateTransformed] = []
    
    weak var delegate: ReloadDataProtocol?
    
    init(apiClient: APIClientProtocol, keychainManager: KeychainManager) {
        self.apiClient = apiClient
        self.keychainManager = keychainManager
    }
    
    func loadCurrencyRates() {
        Task {
            do {
                let result = try await apiClient.asyncRequest(router: APIRouter.rates, response: [CurrencyRateModel].self)
                
                currencyRates = result.map { value in
                    CurrencyRateTransformed(
                        baseCurrency: value.baseCurrency,
                        quoteCurrency: value.quoteCurrency,
                        quote: "\(value.quote)",
                        date: value.date,
                        isSelected: false
                    )
                }
                
                await keychainManager.storeRates(currencyRates)
                
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
}
