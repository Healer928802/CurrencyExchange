//
//  FavoritesViewController.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesView = FavoritesView()
    
    override func loadView() {
        super.loadView()
        
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
