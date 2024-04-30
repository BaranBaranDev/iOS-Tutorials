//
//  UserResponse.swift
//  Example
//
//  Created by Baran Baran on 28.04.2024.
//

import Foundation


// MARK: - UserResponse
struct UserResponse: Codable {
    let data: [Users]
}

// MARK: - Dat
struct Users: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
