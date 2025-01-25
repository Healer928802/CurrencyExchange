//
//  CurrencyListView.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit
import SnapKit

final class CurrencyListView: BaseView {
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.backgroundColor = .red
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        
    }
}
