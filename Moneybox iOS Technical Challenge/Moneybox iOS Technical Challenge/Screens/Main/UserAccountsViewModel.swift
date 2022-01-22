//
//  UserAccountsViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol UserAccountsOutputType {
    
    var userDisplayName: Bindable<String?> { get }
    
    var totalPlanValue: Bindable<String?> { get }
    
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

    
}
