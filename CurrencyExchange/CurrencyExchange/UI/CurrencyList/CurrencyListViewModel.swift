//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

final class CurrencyListViewModel {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func loadCurrencyRates() {
        Task {
            let result = try await apiClient.asyncRequest(router: APIRouter.rates, response: [CurrencyRateModel].self)
            debugPrint(result)
        }
    }
}
