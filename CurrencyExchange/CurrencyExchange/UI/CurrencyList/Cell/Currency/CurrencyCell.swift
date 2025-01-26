//
//  CurrencyCell.swift
//  CurrencyExchange
//
//  Created by Anton on 25.01.2025.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var quoteCurrency: UILabel!
    @IBOutlet private weak var baseCurrency: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var favoritesButton: UIButton!
    
    var cellViewModel: CurrencyCellViewModelProtocol? {
        didSet {
            guard let cellViewModel = cellViewModel as? CurrencyCellViewModel else { return }
            updateCell(with: cellViewModel)
        }
    }
    
    var action: FavoritesAction?
    
    private func updateCell(with cellViewModel: CurrencyCellViewModel) {
        dateLabel.text = cellViewModel.date
        quoteCurrency.text = cellViewModel.quoteCode
        baseCurrency.text = cellViewModel.baseCode
        valueLabel.text = cellViewModel.value
        
        let favoritesImage = cellViewModel.isSelected ? "heart.fill" : "heart"
        favoritesButton.setImage(UIImage(systemName: favoritesImage), for: .normal)
        favoritesButton.tag = cellViewModel.isSelected ? 1 : 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupCell()
    }
    
    private func setupCell() {
        containerView.layer.cornerRadius = 20.0
        containerView.layer.borderWidth = 1.2
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    }
    
    @IBAction private func favoritesClicked(_ sender: UIButton) {
        action?(FavoritesEnum(rawValue: sender.tag) ?? .unowned)
    }
}
