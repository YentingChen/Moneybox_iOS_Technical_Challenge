//
//  UserAccountsViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol InvestorproductTableViewCellViewModelType {
    
    var productNameLabelText: String? { get }
    var planValueLabelText: String? { get }
    var moneyBoxLabelText: String? { get }
}


protocol UserAccountsOutputType {
    
    var userDisplayName: Bindable<String?> { get }
    
    var totalPlanValue: Bindable<String?> { get }
    
    var cellViewModels: Bindable([InvestorproductTableViewCellViewModelType]()) { get }
    
}

protocol UserAccountsInputType {
    
    func didSelectAccount(index: Int)
}

protocol UserAccountsViewModelType: UserAccountsInputType, UserAccountsOutputType {}

class UserAccountsViewModel: UserAccountsViewModelType {
    
    var userDisplayName: Bindable<String?> = Bindable(nil)
    
    var totalPlanValue: Bindable<String?> = Bindable(nil)
    
    var navigator: MainNavigator
    
    init(navigator: MainNavigator) {
        self.navigator = navigator
        userDisplayName.value = "Hi 123!"
        totalPlanValue.value = "50000"
    }
    
    private func bindInputValue() {
        
        
    }
    
    func didSelectAccount(index: Int) {
        
        navigator.showAccountDetail()
        
    }
    
    func getInvestorproducts(token: String) {
        
        let request = InvestorproductsRequst(bearerToken: token)
        networkService.load(request: request) { [weak self] result in
            switch result {
                
            case .success(let response):
                
                if let products = response?.productResponses {
                    
                    self?.cellViewModels.value = products
                    
                    self?.products = products
                    
                }
               
            case .failure(let error):
                break
            }
        }
    }

    
}
