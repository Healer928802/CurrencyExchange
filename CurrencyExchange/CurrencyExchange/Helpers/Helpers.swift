//
//  Helpers.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

typealias FavoritesAction = (FavoritesEnum) -> Void

enum FavoritesEnum: Int {
    case remove = 1
    case add = 0
    case unowned = 2
}
