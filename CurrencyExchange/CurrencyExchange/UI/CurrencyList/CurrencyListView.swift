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
            tableView.registerFromNib(CurrencyCell.self)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
