//
//  LoginViewModel.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation


/// LoginViewModel Input value and action
protocol LoginViewModelInputType {
    
    var emailInput: Bindable<String?> { get  }
    var passwordInput: Bindable<String?> { get }
    
    func loginButtonDidTapped()
}

/// LoginViewModel Output value and action
protocol LoginViewModelOutputType {
    
    var showLoadingIndicator: Bindable<Bool> { get }
    var buttonIsSendableOutput: Bindable<Bool> { get }
    var hideKeyboard: (() -> Void)? { get }
    
}

protocol LoginViewModelType: LoginViewModelInputType, LoginViewModelOutputType, ShowingAlertOutput {}

class LoginViewModel: LoginViewModelType {
    
    var showAlert: ((_ alert: SingleButtonAlert) -> Void)?
    
    var hideKeyboard: (() -> Void)?
    
    var showLoadingIndicator: Bindable<Bool> = Bindable(false)
    
    var emailInput: Bindable<String?> = Bindable(nil)
    
    var passwordInput: Bindable<String?> = Bindable(nil)
    
    var buttonIsSendableOutput: Bindable<Bool> = Bindable(false)
    
    var navigator: LoginNavigator
    
    let networkService = NetworkService<LoginRequest, LoginResponse>()
    
    let authSevice: AuthServiceType
    
    init(navigator: LoginNavigator, authService: AuthServiceType = AuthService.share) {
        
        self.navigator = navigator
        self.authSevice = authService
        
        bindInputValue()
    }
    
    func loginButtonDidTapped() {
        
        hideKeyboard?()
        
        if let emailInput = emailInput.value, let passwordInput = self.passwordInput.value {
            
            if emailInput.isValidEmail() {
                
                postLoginRequest(email: emailInput, password: passwordInput)
                
            } else {
                
                errorAlert(message: "wrong email format, please enter it again")
                
            }
            
        }
        
    }
    
    private func storeDataInAuthService(response: LoginResponse) {
        
        authSevice.bearerToken = response.session?.bearerToken
        authSevice.userDisplayName = response.user?.firstName
        
    }
    
    private func fininishLoginFlow() {
        
        self.navigator.finishLoginFlow()
        
    }
    
    func postLoginRequest(email: String, password: String) {
        
        let request = LoginRequest(userEmail: email, userPassword: password)
        
        self.showLoadingIndicator.value = true
        networkService.load(request: request) { [weak self] result in
            
            self?.showLoadingIndicator.value = false
            
            switch result {
                
            case .success(let response):
                
                guard let response = response else {
                    self?.errorAlert(message: "response is nil!")
                    return
                }
                
                self?.loginSuccess(response)

                
            case .failure(let error):
                
                self?.apiResponseErrorAlert(error: error)
            }
        }
        
    }
    
    func loginSuccess(_ response: LoginResponse) {
        
        self.storeDataInAuthService(response: response)
        
        if Thread.isMainThread {
            
            self.fininishLoginFlow()
            
        } else {
            
            DispatchQueue.main.async {
                
                self.fininishLoginFlow()
                
            }
            
        }
        
    }
    
    private func bindInputValue() {
        
        emailInput.bindAndFire { [unowned self] _ in
            
            self.checkIsSendable(email: emailInput.value, password: passwordInput.value)
            
        }
        
        passwordInput.bindAndFire { [unowned self] _ in
            
            self.checkIsSendable(email: emailInput.value, password: passwordInput.value)
            
        }
    }
    
    /// Check if email and password both contain value, then button is sendable
    func checkIsSendable(email: String?, password: String?) {
        
        if let email = email, let password = password, !password.isEmpty, !email.isEmpty {
            
            self.buttonIsSendableOutput.value = true
            
        } else {
            
            self.buttonIsSendableOutput.value = false
        }
        
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
