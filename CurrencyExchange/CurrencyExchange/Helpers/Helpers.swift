//
//  Helpers.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

typealias FavoritesAction = (FavoritesEnum) -> Void

enum FavoritesEnum {
    case remove(index: IndexPath, object: CurrencyRateTransformed)
    case add(index: IndexPath, object: CurrencyRateTransformed)
    case unowned
}

extension Notification.Name {
    static let updateCurrencyList = Notification.Name("UpdateCurrencyList")
}
