//
//  AppCoordinator.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CurrencyListViewController()
            vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavorites() {
        let vc = FavoritesViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
