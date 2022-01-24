//
//  ShowingAlertOutput.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

protocol ShowingAlertOutput {
    
    var showAlert: ((_ alert: SingleButtonAlert) -> Void)? { get }
    
    func errorAlert(title: String, message: String?)
    
    func apiResponseErrorAlert(error: APIError)
}

extension ShowingAlertOutput {
    
    func errorAlert(title: String = .error, message: String?) {
        
        let action = AlertAction(buttonTitle: .ok, handler: nil)
        let alert = SingleButtonAlert(title: title, message: message, action: action)
        
        self.showAlert?(alert)
    }
    
    func apiResponseErrorAlert(error: APIError) {
        
        let message = error.getErrorMessage()
        
        if let title = error.getErrorTitle() {
            
            self.errorAlert(title: title, message: message)
            
        } else {
            
            self.errorAlert(message: message)
            
        }
        
    }
    
}
