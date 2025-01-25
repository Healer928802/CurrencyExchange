//
//  SceneDelegate.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupCoordinator(windowScene)
    }
    
    private func setupCoordinator(_ windowScene: UIWindowScene) {
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            appWindow.windowScene = windowScene
        let navigationController = UINavigationController()
            navigationController.navigationBar.prefersLargeTitles = false
        
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = appWindow
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

