//
//  APIError.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

enum APIError: Error {
    case clientError
    case parseError
    case serverError
    case unknown
}
