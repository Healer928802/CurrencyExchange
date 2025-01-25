//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    private let currencyListView = CurrencyListView()
    weak var coordinator: AppCoordinator?
    
    override func loadView() {
        super.loadView()
        
        self.view = currencyListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
