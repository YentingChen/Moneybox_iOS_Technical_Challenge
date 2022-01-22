//
//  APIService.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

class APIService<T, U>: APIServiceProtocol where T: RequestProtocol, U: Codable {
    
    typealias RequestDataType = T
    
    typealias ResponseDataType = U
    
    func makeRequest(from request: T) throws -> URLRequest {
        
        return try request.asURLRequest()
    }
    
    func parseResponse(from response: Data) throws -> ResponseDataType {
        
        return try JSONDecoder().decode(ResponseDataType.self, from: response)
    }
    
}
