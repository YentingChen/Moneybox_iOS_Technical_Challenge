//
//  LoginRequest.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

struct LoginRequest: RequestProtocol {
    
    var headers: [String : String]?
    
    var userEmail: String
    
    var userPassword: String
    
    var path: String = "/users/login"
    
    var queryItems: [URLQueryItem]? = nil

    var method: HTTPMethod = .post
    
    var body: Data? {
        
        return "{\"Email\":\"\(userEmail)\",\"Password\":\"\(userPassword)\",\"Idfa\":\"ANYTHING\"}".data(using: .utf8)
    }
    
    init(userEmail: String, userPassword: String) {
        
        self.userEmail = userEmail
        self.userPassword = userPassword
    }

}
