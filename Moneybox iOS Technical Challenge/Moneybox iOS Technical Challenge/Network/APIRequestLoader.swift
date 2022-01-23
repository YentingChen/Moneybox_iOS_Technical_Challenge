//
//  APIRequestLoader.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

class APIRequestLoader<T: APIServiceProtocol> {
    
    var apiService: T
    
    var urlsession: URLSession
    
    init(apiService: T, urlsession: URLSession = .shared) {
        self.apiService = apiService
        self.urlsession = urlsession
    }
    
    func loader(request: T.RequestDataType, completionHandler: @escaping (Result<T.ResponseDataType?, APIError>) -> Void) {
        
        do {
            
            let urlRequest = try apiService.makeRequest(from: request)
            
            urlsession.dataTask(with: urlRequest) { [weak self] data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    switch httpResponse.statusCode {
                        
                    case 200:
                        
                        do {
                            guard let data = data else {
    
                                return completionHandler(.success(nil))
                            }
                            
                            let response = try self?.apiService.parseResponse(from: data)
                            
                            completionHandler(.success(response))
                            
                        } catch {
                            completionHandler(.failure(.parseError))
                        }
                        
                    case 400..<500:
                        
                        do {
                            guard let data = data else {
    
                                return completionHandler(.failure(.clientError(nil)))
                            }
                            
                            let response = try self?.apiService.parseErrorResponse(from: data)
                            
                            completionHandler(.failure(.clientError(response)))
                            
                        } catch {
                            completionHandler(.failure(.clientError(nil)))
                        }
                        
                    case 500..<600:
                        
                        completionHandler(.failure(.serverError))
                        
                    default:
                        
                        completionHandler(.failure(.unknown))
                        
                    }
                }
            }.resume()
            
        } catch {
            
            completionHandler(.failure(.unknown))
            
        }
        
    }
}
