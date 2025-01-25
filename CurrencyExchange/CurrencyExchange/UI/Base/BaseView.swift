//
//  BaseView.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
