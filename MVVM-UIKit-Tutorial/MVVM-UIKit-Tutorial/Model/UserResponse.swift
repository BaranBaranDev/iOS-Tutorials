//
//  UserResponse.swift
//  MVVM
//
//  Created by Baran Baran on 26.04.2024.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let data: [PersonResponse]
}

// MARK: - PersonResponse
struct PersonResponse: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

}
