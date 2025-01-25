//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

final class CurrencyListViewModel {
    private let apiClient: APIClientProtocol
    
    private(set) var currencyRates: [CurrencyRateModel] = []
    
    weak var delegate: ReloadDataProtocol?
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func loadCurrencyRates() {
        Task {
            currencyRates = try await apiClient.asyncRequest(router: APIRouter.rates, response: [CurrencyRateModel].self)
            
            await MainActor.run {
                delegate?.reloadData()
            }
        }
    }
}
