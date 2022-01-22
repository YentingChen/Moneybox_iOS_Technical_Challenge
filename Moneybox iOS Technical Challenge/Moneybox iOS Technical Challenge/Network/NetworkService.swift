//
//  NetworkService.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

class NetworkService<T, U> where T: RequestProtocol, U: Codable {
    
    private let apiService = APIService<T, U>()
    
    private lazy var loader = APIRequestLoader(apiService: apiService)
    
    func load(request: T, completionHandler: @escaping (Result<U?, APIError>) -> Void) {
        loader.loader(request: request, completionHandler: completionHandler)
    }
}
