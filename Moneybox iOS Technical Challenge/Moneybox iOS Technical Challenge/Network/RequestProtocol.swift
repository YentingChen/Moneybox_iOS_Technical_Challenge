//
//  RequestProtocol.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol RequestProtocol {
    
    var scheme: String { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    var headers: [String : String]? { get }
    
    var method: HTTPMethod { get }
    
    var body: Data? { get }
    
    var baseHeaders: [String : String] { get }
    
}

extension RequestProtocol {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return  "api-test02.moneyboxapp.com"
    }
    
    var baseHeaders: [String : String] {
        
        return [
            "AppId" : "8cb2237d0679ca88db6464",
            "Content-Type" : "application/json",
            "appVersion" : "7.10.0",
            "apiVersion": "3.0.0"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        var urlRequest = URLRequest(url: (components.url)!)
        urlRequest.httpMethod = method.rawValue
        
        var headrFields = baseHeaders
        if let headers = headers {
            
            headers.forEach { (key, value) in headrFields[key] = value }
        }
        
        urlRequest.allHTTPHeaderFields = headrFields
        urlRequest.httpBody = body
        
        return urlRequest
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
