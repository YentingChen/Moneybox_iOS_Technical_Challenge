//
//  APIServiceProtocol.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol APIServiceProtocol {
    
    associatedtype RequestDataType
    associatedtype ResponseDataType
    
    func makeRequest(from request: RequestDataType) throws -> URLRequest
    func parseResponse(from response: Data) throws -> ResponseDataType
}

extension APIServiceProtocol {
    
    func parseErrorResponse(from response: Data) throws -> MoneyboxErrorResponse {
        
        return try JSONDecoder().decode(MoneyboxErrorResponse.self, from: response)
    }
}
