//
//  UserAccountDetailViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

protocol UserAccountDetailViewModelInputType {

    func didTappedButton()
}

protocol UserAccountDetailViewModelOutputType {
    
    var buttonDisplayText: Bindable<String?> { get }
    var productDetail: Bindable<ProductResponse?> { get }
    
}

protocol UserAccountDetailViewModelType: UserAccountDetailViewModelInputType, UserAccountDetailViewModelOutputType, ShowingAlertOutput, ShowingLoadingIndicatorOutput {}

class UserAccountDetailViewModel: UserAccountDetailViewModelType {
    
    var showAlert: ((SingleButtonAlert) -> Void)?
    
    let amountToAdd = Bindable<Int>(10)
    
    let productDetail = Bindable<ProductResponse?>(nil)

    let buttonDisplayText = Bindable<String?>(nil)
    
    let showLoadingIndicator: Bindable<Bool> = Bindable(false)
    
    let networkService = NetworkService<OneoffpaymentsRequest, OneoffpaymentsSuccessResponse>()
    
    var auth: AuthServiceType
    
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
    
    func postOneoffpaymentsRequest() {
        
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
                
                self?.apiResponseErrorAlert(error: error)
            }
            
        }
        
    }
    
    func didTappedButton() {
    
        postOneoffpaymentsRequest()
        
    }
    
}
