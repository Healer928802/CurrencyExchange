//
//  Protocols.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

enum ReloadStates {
    case noConnection
    case noFavorites
    case noRatesStored
    case success
    
    var message: String {
        switch self {
        case .noConnection:
            "No internet connection. Please check your network settings."
        case .noFavorites:
            "You have no favorites added. Start adding your favorite items!"
        case .noRatesStored:
            "No rates have been stored and the Internet connection appears to be offline. Please check your network settings."
        case .success:
            "Operation completed successfully!"
        }
    }
}

protocol ReloadDataProtocol: AnyObject {
    func reloadData(with state: ReloadStates)
}
