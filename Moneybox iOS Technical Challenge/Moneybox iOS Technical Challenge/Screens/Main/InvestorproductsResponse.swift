//
//  InvestorproductsResponse.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

// MARK: - InvestorproductsResponse
struct InvestorproductsResponse: Codable {
    
    let totalPlanValue: Double?
    let productResponses: [ProductResponse]?
    let product: Product?

    enum CodingKeys: String, CodingKey {
       
        case totalPlanValue = "TotalPlanValue"
        case productResponses = "ProductResponses"
        case product = "Product"
    }
}

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let id: Int?
    let planValue: Double?
    let moneybox: Int?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case planValue = "PlanValue"
        case moneybox = "Moneybox"
        
    }
}


// MARK: - Product
struct Product: Codable {
    let id: Int?
    let name, friendlyName: String?
    

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case friendlyName = "FriendlyName"
        
    }
}

