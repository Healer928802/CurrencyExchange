//
//  CurrencyListEmptyCell.swift
//  CurrencyExchange
//
//  Created by Anton on 26.01.2025.
//

import UIKit

final class CurrencyListEmptyCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var errorMessage: UILabel!
    
    var state: ReloadStates? {
        didSet {
            guard let state = state else { return }
            errorMessage.text = state.message
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 20.0
        containerView.layer.borderWidth = 1.2
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    }
}
