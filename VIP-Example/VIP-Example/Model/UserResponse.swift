//
//  UserResponse.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation


struct UserResponse:Codable {
    let id: Int
    let name: String
    let email: String
    let address: UserAddress
}

struct UserAddress:Codable {
    let city: String
}
