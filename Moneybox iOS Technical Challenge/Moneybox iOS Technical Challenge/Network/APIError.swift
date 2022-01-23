//
//  APIError.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

enum APIError: Error {
    case clientError(MoneyboxErrorResponse?)
    case parseError
    case serverError
    case unknown
    
    func getErrorTitle() -> String? {
        
        switch self {
            
        case .clientError(let response):
            return response?.name
            
        case .serverError:
            return "Server Error"
        
        case .parseError:
            return "Parse Error"
            
        default:
            return "Error"
        }
    }
    
    func getErrorMessage() -> String? {
        
        switch self {
            
        case .clientError(let response):
            return response?.message
        case .serverError:
            return "Server error, please wait for a moment"
        case .parseError:
            return "Sorry, this is a thechnical issue, please report it to us"
        default:
            return "Error"
        }
    }
}
