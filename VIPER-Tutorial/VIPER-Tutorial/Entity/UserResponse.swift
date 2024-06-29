//
//  UserResponse.swift
//  VIPER-Tutorial
//
//  Created by Baran Baran on 29.06.2024.
//


import Foundation


struct UserEntity:Codable {
    let id: Int
    let name: String
    let email: String
    let address: UserAddress
}

struct UserAddress:Codable {
    let city: String
}
