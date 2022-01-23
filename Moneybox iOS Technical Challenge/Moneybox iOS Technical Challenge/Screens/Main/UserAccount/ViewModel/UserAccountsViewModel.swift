//
//  UserAccountsViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation


protocol UserAccountsOutputType {
    
    var userDisplayName: Bindable<String?> { get }
    
    var totalPlanValueText: Bindable<String?> { get }
    
    var cellViewModels: Bindable<[InvestorproductTableViewCellViewModelType]> { get }
    
}

protocol UserAccountsInputType {
    
    func viewWillAppear()
    
    func didSelectAccount(index: Int)
    
    func didTappedLogoutButton()
}

protocol UserAccountsViewModelType: UserAccountsInputType, UserAccountsOutputType {}

class UserAccountsViewModel: UserAccountsViewModelType {
    
    var cellViewModels = Bindable<[InvestorproductTableViewCellViewModelType]>([])
    
    private var products: [ProductResponse] = []
    
    var userDisplayName: Bindable<String?> = Bindable(nil)
    
    var totalPlanValue: Bindable<Double?> = Bindable(nil)
    
    var totalPlanValueText: Bindable<String?> = Bindable(nil)
    
    let showLoadingIndicator: Bindable<Bool> = Bindable(false)
    
    var navigator: MainNavigator
    
    var networkService =  NetworkService<InvestorproductsRequst, InvestorproductsResponse>()
    
    var authService: AuthServiceType
    
    init(navigator: MainNavigator, authService: AuthServiceType = AuthService.share) {
        self.navigator = navigator
        self.authService = authService
        userDisplayName.value = "Hi \(authService.userDisplayName ?? "")!"
        bindingValue()
    }
    
    func viewWillAppear() {
         
        getInvestorproducts(token: authService.bearerToken)
        
    }
    
    func bindingValue() {
        
        totalPlanValue.bindAndFire { [unowned self] value in
            
            let valueText: String = value == nil ? "--" : value!.description
            self.totalPlanValueText.value = "Total Plan Value: £\(valueText)"
        }
    }
    
    func didSelectAccount(index: Int) {
        
        guard index < products.count else {
            //Alert
            return
        }
        navigator.showAccountDetail(product: self.products[index])
        
    }
    
    func didTappedLogoutButton() {
        
        authService.clearAuthData()
        
        navigator.finishMainFlow()
    }
    
    func getInvestorproducts(token: String?) {
        
        guard let token = authService.bearerToken else {
            //Show Error
            return
        }
        let request = InvestorproductsRequst(bearerToken: token)
        showLoadingIndicator.value = true
        networkService.load(request: request) { [weak self] result in
            self?.showLoadingIndicator.value = false
            switch result {
                
            case .success(let response):
                
                if let products = response?.productResponses {
                    
                    self?.cellViewModels.value = products
                    
                    self?.products = products
                    
                    self?.totalPlanValue.value = response?.totalPlanValue
                    
                }
               
            case .failure(let error):
                break
            }
        }
    }

}
