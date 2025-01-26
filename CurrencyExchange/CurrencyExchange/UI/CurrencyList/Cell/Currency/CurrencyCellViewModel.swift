//
//  CurrencyCellViewModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

protocol CurrencyCellViewModelProtocol {}

final class CurrencyCellViewModel: CurrencyCellViewModelProtocol {
    var value: String
    var baseCode: String
    var quoteCode: String
    var isSelected: Bool
    var date: String
    var indexPath: IndexPath
    
    init(value: String, baseCode: String, quoteCode: String, isSelected: Bool, date: String, indexPath: IndexPath) {
        self.value = value
        self.baseCode = baseCode
        self.quoteCode = quoteCode
        self.isSelected = isSelected
        self.date = date
        self.indexPath = indexPath
    }
}
