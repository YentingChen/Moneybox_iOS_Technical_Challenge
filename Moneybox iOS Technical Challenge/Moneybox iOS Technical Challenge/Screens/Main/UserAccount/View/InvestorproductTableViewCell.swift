//
//  InvestorproductTableViewCell.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit

class InvestorproductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cornerBackgroundView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyBoxLabel: UILabel!
    
    var viewModel: InvestorproductTableViewCellViewModelType? {
        
        didSet {
            
            bindViewModel()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    func bindViewModel() {
        productNameLabel.text = viewModel?.productNameLabelText
        planValueLabel.text = viewModel?.planValueLabelText
        moneyBoxLabel.text = viewModel?.moneyBoxLabelText
    }
    
    func configureUI() {
        
        cornerBackgroundView.layer.cornerRadius = 16
        cornerBackgroundView.backgroundColor = UIColor.lightGray
        
        productNameLabel.numberOfLines = 1
        planValueLabel.numberOfLines = 1
        moneyBoxLabel.numberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productNameLabel.text = "N/A"
        planValueLabel.text = "Plan Value: £N/A"
        moneyBoxLabel.text = "Money box: £N/A"
    }
    
}

