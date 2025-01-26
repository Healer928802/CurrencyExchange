//
//  CurrencyListEmptySetupCell.swift
//  CurrencyExchange
//
//  Created by Anton on 26.01.2025.
//

import UIKit

struct CurrencyListEmptySetupCell: TableCellSetupController {
    let state: ReloadStates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.size.height - 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CurrencyListEmptyCell.self, forIndexPath: indexPath)
        cell.state = state
        return cell
    }
}
