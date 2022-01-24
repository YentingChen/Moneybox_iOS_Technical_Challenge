//
//  AuthServiceType.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol AuthServiceType: AnyObject {
    var userDisplayName: String? { get set }
    var bearerToken: String? { get set }
    func clearAuthData()
}

extension AuthServiceType {
    
    func clearAuthData() {
        
        userDisplayName = nil
        bearerToken = nil
        
    }
}

class AuthService: AuthServiceType {
   
    var userDisplayName: String?
    var bearerToken: String?
    
    // MARK: - Singleton
    static let share = AuthService()
    private init() {
        
    }
    

}
