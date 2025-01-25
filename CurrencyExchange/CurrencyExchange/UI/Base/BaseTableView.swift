//
//  BaseTableView.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

class BaseTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .clear
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
