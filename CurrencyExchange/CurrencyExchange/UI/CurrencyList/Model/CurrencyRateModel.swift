//
//  CurrencyRateModel.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

struct CurrencyRateModel: Codable {
    let baseCurrency: String
    let quoteCurrency: String
    let quote: Double
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case baseCurrency = "base_currency"
        case quoteCurrency = "quote_currency"
        case quote, date
    }
}
