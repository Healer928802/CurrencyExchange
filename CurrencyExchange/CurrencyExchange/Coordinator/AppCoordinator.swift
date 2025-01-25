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
    
    init(navigationController: UINavigationController, apiClient: APIClientProtocol) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func start() {
        let viewModel = CurrencyListViewModel(apiClient: apiClient)
        let vc = CurrencyListViewController(viewModel: viewModel)
            vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavorites() {
        let vc = FavoritesViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
