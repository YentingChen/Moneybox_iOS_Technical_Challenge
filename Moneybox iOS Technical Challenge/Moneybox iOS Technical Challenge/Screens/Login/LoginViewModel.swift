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
    
    var buttonIsSendableOutput: Bindable<Bool> { get }
    
}

protocol LoginViewModelType: LoginViewModelInputType, LoginViewModelOutputType {}

class LoginViewModel: LoginViewModelType {
    
    var emailInput: Bindable<String?> = Bindable(nil)
    
    var passwordInput: Bindable<String?> = Bindable(nil)
    
    var buttonIsSendableOutput: Bindable<Bool> = Bindable(false)
    
    var navigator: LoginNavigator
    
    init(navigator: LoginNavigator) {
        
        self.navigator = navigator
        
        bindInputValue()
    }
    
    func loginButtonDidTapped() {
        
        navigator.finishLoginFlow()
        
    }
    
    private func bindInputValue() {
        
        emailInput.bind { [unowned self] email in
            
            self.checkIsSendable()
            
        }
        
        passwordInput.bind { [unowned self] email in
            
            self.checkIsSendable()
            
        }
    }
    
    /// Check if email and password both contain value, then button is sendable
    private func checkIsSendable() {
        
        if let email = emailInput.value, let password = passwordInput.value, !password.isEmpty, !email.isEmpty {
            
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
