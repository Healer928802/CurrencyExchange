//
//  AppCoordinator.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private let apiClient: APIClientProtocol
    private let keychainManager: KeychainManager
    
    init(navigationController: UINavigationController, apiClient: APIClientProtocol, keychainManager: KeychainManager) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.keychainManager = keychainManager
    }
    
    func start() {
        let viewModel = CurrencyListViewModel(apiClient: apiClient, keychainManager: keychainManager)
        let vc = CurrencyListViewController(viewModel: viewModel)
            vc.title = "Currency Exchange List"
            vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavorites() {
        let vc = FavoritesViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
