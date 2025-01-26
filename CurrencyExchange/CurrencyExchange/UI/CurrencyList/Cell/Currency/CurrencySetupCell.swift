//
//  CurrencySetupCell.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

struct CurrencySetupCell: TableCellSetupController {
    let rates: [CurrencyRateModel]
    
    var action: FavoritesAction?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CurrencyCell.self, forIndexPath: indexPath)
        let result = rates[indexPath.row]
        cell.action = action
        cell.cellViewModel = CurrencyCellViewModel(
            value: "\(result.quote)",
            baseCode: result.baseCurrency,
            quoteCode: result.quoteCurrency,
            isSelected: false,
            date: result.date
        )
        return cell
    }
}

