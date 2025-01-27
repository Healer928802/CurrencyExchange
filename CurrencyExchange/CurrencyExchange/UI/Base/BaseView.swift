//
//  BaseView.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit
import SnapKit

final class BaseView: UIView {
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.registerFromNib(CurrencyCell.self)
        tableView.registerFromNib(CurrencyListEmptyCell.self)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
