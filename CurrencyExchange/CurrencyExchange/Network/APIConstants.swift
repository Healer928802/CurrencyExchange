//
//  APIConstants.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://swop.cx/rest"
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-type"
    case accept = "Accept"
}

enum ContentType: String {
    case json = "application/json"
    case textPlain = "text/plain"
}
