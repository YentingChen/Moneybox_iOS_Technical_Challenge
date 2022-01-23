//
//  OneoffpaymentsSuccessResponse.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

// MARK: - OneoffpaymentsSuccessResponse
struct OneoffpaymentsSuccessResponse: Codable {
    let moneybox: Double

    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
       
    }
}
