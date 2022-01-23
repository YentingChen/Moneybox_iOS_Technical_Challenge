//
//  UserAccountDetailViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

class UserAccountDetailViewModel {
    
    var auth: AuthServiceType
    
    var productDetail = Bindable<ProductResponse?>(nil)
    
    let amountToAdd = Bindable<Int>(10)
    
    let buttonDisplayText = Bindable<String?>(nil)
    
    let showLoadingIndicator: Bindable<Bool> = Bindable(false)
    
    let networkService = NetworkService<OneoffpaymentsRequest, OneoffpaymentsSuccessResponse>()
    
    init(auth: AuthServiceType = AuthService.share, detail: ProductResponse) {
        
        self.auth = auth
        self.productDetail.value = detail
        bindingValue()
    }
    
    func bindingValue() {
        
        amountToAdd.bindAndFire { [unowned self] value in
            
            self.buttonDisplayText.value = "Add £\(value)"
            
        }
    }
    
    private func postOneoffpaymentsRequest() {
        
        guard let token = auth.bearerToken else { return }
        guard let productId = productDetail.value?.id else { return }
        
        let request = OneoffpaymentsRequest(bearerToken: token, amount: amountToAdd.value, productId: productId)
        
        showLoadingIndicator.value = true
        networkService.load(request: request) { [weak self] result in
            self?.showLoadingIndicator.value = false
            
            switch result {
                
            case .success(let response):
                
                DispatchQueue.main.async {
                    
                    self?.productDetail.value?.moneybox = response?.moneybox

                }
                
            case .failure(let error):
                
                break
            }
            
        }
        
    }
    
    func didTappedButton() {
    
        postOneoffpaymentsRequest()
        
    }
    
}
