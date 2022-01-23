//
//  OneoffpaymentsRequest.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

struct OneoffpaymentsRequest: RequestProtocol {
    
    var bearerToken: String
    
    var amount: Int
    
    var productId: Int
    
    var path: String {
        
        return "/oneoffpayments"
    }
    
    var queryItems: [URLQueryItem]? = nil
    
    var method: HTTPMethod = .post
    
    var body: Data? {
        
        return "{\"Amount\":\(amount),\"InvestorProductId\":\(productId)}".data(using: .utf8)
    }
    
    var headers: [String : String]? {
        
        return [
            "Authorization" : "Bearer \(bearerToken)"
        ]
    }
    
    
    
    
}
