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
    private var cellSetupController: [TableCellSetupController] = []
    
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
        
        setupNavigationView()
        viewModel.delegate = self
        viewModel.loadCurrencyRates()
    }
    
    private func setupNavigationView() {
        let image = UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showFavorites))
    }
    
    @objc private func showFavorites() {
        coordinator?.showFavorites()
    }
}

extension CurrencyListViewController: ReloadDataProtocol {
    func reloadData(with state: ReloadStates) {
        currencyListView.tableView.delegate = self
        currencyListView.tableView.dataSource = self
        
        switch state {
        case .success, .noConnection:
            cellSetupController.append(CurrencySetupCell(rates: viewModel.currencyRates, action: handleFavoritesAction()))
        case .noRatesStored:
            currencyListView.tableView.registerFromNib(CurrencyListEmptyCell.self)
            cellSetupController.append(CurrencyListEmptySetupCell(state: state))
        case .noFavorites:
            break
        }
        
        currencyListView.tableView.reloadData()
    }
    
    private func handleFavoritesAction() -> FavoritesAction? {
        return { [weak self] result in
            switch result {
            case .add:
                print("Add")
            case .remove:
                print("Remove")
            case .unowned:
                break
            }
        }
    }
}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellSetupController[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellSetupController[indexPath.section].tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellSetupController[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
}
