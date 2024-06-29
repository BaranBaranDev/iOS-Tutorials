//
//  UserResponse.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//

import Foundation


// MARK: UserResponse
struct UserResponse: Codable {
    let id: Int
    let name: String
    let email: String
    let address: UserAddress
}

// MARK: UserAddress
struct UserAddress: Codable {
    let city: String
}
