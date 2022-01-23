//
//  UserAccountDetailViewController.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit

class UserAccountDetailViewController: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var moneyboxLabel: UILabel!
    @IBOutlet weak var moneyAddedButton: UIButton!
    
    @IBOutlet weak var loadingIndicatorView: LoadingIndicatorView!
    let viewModel: UserAccountDetailViewModel

    init(viewModel: UserAccountDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        moneyAddedButton.addTarget(self, action: #selector(moneyAddedButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func moneyAddedButtonTapped(sender: UIButton) {
        
        viewModel.didTappedButton()
        
    }
    
    private func bindViewModel() {
        
        viewModel.productDetail.bindAndFire { [weak self] response in
            self?.productNameLabel.text = response?.productNameLabelText
            self?.planValueLabel.text = response?.planValueLabelText
            self?.moneyboxLabel.text = response?.moneyBoxLabelText
        }
        
        viewModel.buttonDisplayText.bindAndFire { [weak self] buttonText in
            
            self?.moneyAddedButton.setTitle(buttonText, for: .normal)
        }
        
        viewModel.showLoadingIndicator.bindAndFire { [weak self] showIndicator in
            
            DispatchQueue.main.async {
                self?.loadingIndicatorView.isHidden = !showIndicator
            }
        }
    
    }
    
}
