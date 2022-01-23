//
//  NetworkServiceTests.swift
//  Moneybox iOS Technical ChallengeTests
//
//  Created by Yenting Chen on 2022/1/23.
//

import XCTest
@testable import Moneybox_iOS_Technical_Challenge

class NetworkServiceTests: XCTestCase {

    //MARK: - URLRequest Tests
    func test_login_makeRequest() throws {
        ///GIVEN
        let userEmail = "user@email.com"
        let password = "password"
        let body = "{\"Email\":\"\(userEmail)\",\"Password\":\"\(password)\",\"Idfa\":\"ANYTHING\"}".data(using: .utf8)
        let apiService = APIService<LoginRequest, LoginResponse>()
        let request = LoginRequest(userEmail: userEmail, userPassword: password)
        
        ///WHEN
        let loginURLRequest = try apiService.makeRequest(from: request)
        
        ///THEN
        XCTAssertEqual(loginURLRequest.url?.absoluteString, "https://api-test02.moneyboxapp.com/users/login")
        XCTAssertEqual(loginURLRequest.allHTTPHeaderFields
                       , ["AppId" : "8cb2237d0679ca88db6464",
                          "Content-Type" : "application/json",
                          "appVersion" : "7.10.0",
                          "apiVersion" :"3.0.0"])
        XCTAssertEqual(loginURLRequest.httpBody, body)
        XCTAssertEqual(loginURLRequest.httpMethod, "POST")
        
    }
    
    func test_getProducts_makeRequest() throws {
        ///GIVEN
        let token = "1234"
        let apiService = APIService<InvestorproductsRequst, InvestorproductsResponse>()
        let request = InvestorproductsRequst(bearerToken: token)
        
        ///WHEN
        let productsURLRequest = try apiService.makeRequest(from: request)
        
        ///THEN
        XCTAssertEqual(productsURLRequest.url?.absoluteString, "https://api-test02.moneyboxapp.com/investorproducts")
        XCTAssertEqual(productsURLRequest.allHTTPHeaderFields
                       , ["AppId" : "8cb2237d0679ca88db6464",
                          "Content-Type" : "application/json",
                          "appVersion" : "7.10.0",
                          "apiVersion" :"3.0.0",
                          "Authorization" : "Bearer \(token)"])
        XCTAssertEqual(productsURLRequest.httpMethod, "GET")
        
    }
    
    func test_postPayment_makeRequest() throws {
        ///GIVEN
        let token = "1234"
        let amount = 10
        let productId = 8888
        let body = "{\"Amount\":\(amount),\"InvestorProductId\":\(productId)}".data(using: .utf8)
        let apiService = APIService<OneoffpaymentsRequest, OneoffpaymentsSuccessResponse>()
        let request = OneoffpaymentsRequest(bearerToken: token, amount: amount, productId: productId)
        
        ///WHEN
        let postPaymentURLRequest = try apiService.makeRequest(from: request)
        
        ///THEN
        XCTAssertEqual(postPaymentURLRequest.url?.absoluteString, "https://api-test02.moneyboxapp.com/oneoffpayments")
        XCTAssertEqual(postPaymentURLRequest.allHTTPHeaderFields
                       , ["AppId" : "8cb2237d0679ca88db6464",
                          "Content-Type" : "application/json",
                          "appVersion" : "7.10.0",
                          "apiVersion" :"3.0.0",
                          "Authorization" : "Bearer \(token)"])
        XCTAssertEqual(postPaymentURLRequest.httpBody, body)
        XCTAssertEqual(postPaymentURLRequest.httpMethod, "POST")
        
    }
    
    //MARK: - Response Tests
    func test_login_parseResonse() throws {
        
        // GIVEN
        let apiService = APIService<LoginRequest, LoginResponse>()
        
        let responseURL = Bundle.main.url(forResource: "MockUserLoginResponse", withExtension: "json")
        let responseData = try Data(contentsOf: responseURL!)
        
        //WHEN
        let urlResponse = try apiService.parseResponse(from: responseData)
        
        //THEN
        XCTAssertEqual(urlResponse.user?.firstName, "Michael")
        
    }
    
    func test_getProducts_parseResonse() throws {
        
        // GIVEN
        let apiService = APIService<InvestorproductsRequst, InvestorproductsResponse>()
        
        let responseURL = Bundle.main.url(forResource: "MockInvestroproductsResponse", withExtension: "json")
        let responseData = try Data(contentsOf: responseURL!)
        
        //WHEN
        let urlResponse = try apiService.parseResponse(from: responseData)
        
        //THEN
        XCTAssertEqual(urlResponse.totalPlanValue, 17174.270000)
        
    }
    
    func test_postPayment_parseResonse() throws {
        
        // GIVEN
        let apiService = APIService<OneoffpaymentsRequest, OneoffpaymentsSuccessResponse>()
        
        let responseURL = Bundle.main.url(forResource: "MockOneoffpaymentsSuccessResponse", withExtension: "json")
        let responseData = try Data(contentsOf: responseURL!)
        
        //WHEN
        let urlResponse = try apiService.parseResponse(from: responseData)
        
        //THEN
        XCTAssertEqual(urlResponse.moneybox, 30.00)
        
    }
    
}


