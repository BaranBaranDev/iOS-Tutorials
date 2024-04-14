//
//  User.swift
//  NetworkLayer
//
//  Created by Baran Baran on 3.04.2024.
//

import Foundation

// Codable = Decodable + Encodable
// Model klasöründe ki struct ile oluşturlan modeller json içerisinde ki verilerin swiftte ki karşılığıdır.

struct User: Codable {
    let id : Int
    let name : String
    let username: String
    let email: String
    let address : Address
}

struct Address: Codable {
    let city: String
}
