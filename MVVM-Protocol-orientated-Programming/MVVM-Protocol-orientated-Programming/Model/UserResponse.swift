//
//  UserResponse.swift
//  protocol-orientated-programming
//
//  Created by Baran Baran on 27.04.2024.
//

import Foundation

struct UserResponse: Decodable {
  let data: User
}

struct User: Decodable {
  let id: Int
  let email: String
  let avatar: String
}
