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
    
    private var viewModel: CurrencyListViewModel
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init error")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = currencyListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
