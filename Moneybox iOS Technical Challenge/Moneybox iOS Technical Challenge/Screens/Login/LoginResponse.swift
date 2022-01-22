//
//  LoginResponse.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

// MARK: - LoginResponse
struct LoginResponse: Codable {
    var user: User?
    var session: Session?

    enum CodingKeys: String, CodingKey {
        case user = "User"
        case session = "Session"
    }
}

// MARK: - Session
struct Session: Codable {
    var bearerToken: String?

    enum CodingKeys: String, CodingKey {
        case bearerToken = "BearerToken"

    }
}

// MARK: - User
struct User: Codable {
    
    var userID: String?
    var firstName, lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case firstName = "FirstName"
        case lastName = "LastName"
    }
}
