//
//  Helpers.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

typealias FavoritesAction = (FavoritesEnum) -> Void

enum FavoritesEnum {
    case remove(index: IndexPath)
    case add(index: IndexPath)
    case unowned
}
