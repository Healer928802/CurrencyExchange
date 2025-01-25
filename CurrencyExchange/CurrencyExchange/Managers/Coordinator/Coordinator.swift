//
//  Coordinator.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
