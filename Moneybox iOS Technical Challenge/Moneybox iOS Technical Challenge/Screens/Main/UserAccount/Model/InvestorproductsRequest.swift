//
//  InvestorproductsRequest.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

struct InvestorproductsRequst: RequestProtocol {
    
    var headers: [String : String]? {
        
        return [
            "Authorization" : "Bearer \(bearerToken)"
        ]
    }
    
    var bearerToken: String
    
    var path: String {
        
        return "/investorproducts"
    }
    
    var queryItems: [URLQueryItem]?
    
    var method: HTTPMethod = .get
    
    var body: Data? = nil
    
}
