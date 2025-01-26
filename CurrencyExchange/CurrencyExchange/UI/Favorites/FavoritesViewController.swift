//
//  FavoritesViewController.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesView = BaseView()
    
    private var viewModel: FavoritsViewModel
    private var cellSetupController: [TableCellSetupController] = []
    
    private let notificationCenter = NotificationCenter.default
    
    init(viewModel: FavoritsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.retrieveFavorites()
    }
}

extension FavoritesViewController: ReloadDataProtocol {
    func reloadData(with state: ReloadStates) {
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        
        switch state {
        case .success:
            cellSetupController.append(CurrencySetupCell(rates: viewModel.favoriteRates, action: handleFavoritesAction()))
        case .noFavorites:
            cellSetupController.append(CurrencyListEmptySetupCell(state: state))
        default:
            break
        }
        
        favoritesView.tableView.reloadData()
    }
    
    private func handleFavoritesAction() -> FavoritesAction? {
        return { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .remove(_ , let object):
                if let existingIndex = self.viewModel.favoriteRates.firstIndex(where: {
                    $0.baseCurrency == object.baseCurrency && $0.quoteCurrency == object.quoteCurrency
                }) {
                    self.viewModel.favoriteRates.remove(at: existingIndex)
                }
                            
                if let ratesIndex = self.viewModel.currencyRates.firstIndex(where: {
                    $0.baseCurrency == object.baseCurrency && $0.quoteCurrency == object.quoteCurrency
                }) {
                    self.viewModel.currencyRates[ratesIndex].isSelected = false
                }
                        
                self.viewModel.keychainManager.storeRates(self.viewModel.favoriteRates, with: .favoriteRates)
                
                if viewModel.favoriteRates.isEmpty {
                    self.cellSetupController[0] = CurrencyListEmptySetupCell(state: .noFavorites)
                } else {
                    self.cellSetupController[0] = CurrencySetupCell(rates: self.viewModel.favoriteRates, action: self.handleFavoritesAction())
                }
                
                self.favoritesView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                
                self.notificationCenter.post(name: .updateCurrencyList, object: self.viewModel.currencyRates)
            case .unowned, .add:
                break
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
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
