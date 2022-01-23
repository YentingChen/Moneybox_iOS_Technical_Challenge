//
//  MoneyboxErrorResponse.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

import Foundation

// MARK: - MoneyboxErrorResponse
struct MoneyboxErrorResponse: Codable {
    let name, message: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case message = "Message"
    }
}
