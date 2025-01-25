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
}
