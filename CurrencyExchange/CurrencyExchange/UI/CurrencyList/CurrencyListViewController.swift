//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    private let currencyListView = BaseView()
    weak var coordinator: AppCoordinator?
    
    private var viewModel: CurrencyListViewModel
    private var cellSetupController: [TableCellSetupController] = []
    
    private let notificationCenter = NotificationCenter.default
    
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
        notificationCenter.addObserver(self, selector: #selector(updateCurrencyList(_:)), name: .updateCurrencyList, object: nil)
    }
    
    @objc private func updateCurrencyList(_ notification: Notification) {
        if let currencyRates = notification.object as? [CurrencyRateTransformed] {
            viewModel.updateFavorites()
            viewModel.currencyRates = currencyRates
            cellSetupController[0] = CurrencySetupCell(rates: viewModel.currencyRates, action: handleFavoritesAction())
            currencyListView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    private func setupNavigationView() {
        let image = UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showFavorites))
    }
    
    @objc private func showFavorites() {
        coordinator?.showFavorites(with: viewModel.currencyRates)
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
            cellSetupController.append(CurrencyListEmptySetupCell(state: state))
        case .noFavorites:
            break
        }
        
        currencyListView.tableView.reloadData()
    }
    
    private func handleFavoritesAction() -> FavoritesAction? {
        return { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .add(let index, let object):
                self.viewModel.favoriteCurrencyRates.append(object)
                
                if index.row < self.viewModel.currencyRates.count {
                    self.viewModel.currencyRates[index.row].isSelected = true
                }
                
                self.viewModel.keychainManager.storeRates(self.viewModel.favoriteCurrencyRates, with: .favoriteRates)
                
                self.cellSetupController[0] = CurrencySetupCell(rates: self.viewModel.currencyRates, action: self.handleFavoritesAction())
                self.currencyListView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            
            case .remove(let index, let object):
                if let existingIndex = self.viewModel.favoriteCurrencyRates.firstIndex(where: {
                    $0.baseCurrency == object.baseCurrency && $0.quoteCurrency == object.quoteCurrency
                }) {
                    self.viewModel.favoriteCurrencyRates.remove(at: existingIndex)
                }
                
                if index.row < self.viewModel.currencyRates.count {
                    self.viewModel.currencyRates[index.row].isSelected = false
                }
                
                self.viewModel.keychainManager.storeRates(self.viewModel.favoriteCurrencyRates, with: .favoriteRates)
                
                self.cellSetupController[0] = CurrencySetupCell(rates: self.viewModel.currencyRates, action: self.handleFavoritesAction())
                self.currencyListView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
