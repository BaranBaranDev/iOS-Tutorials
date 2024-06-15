//
//  HomeModels.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//


import UIKit

enum HomeModels {
  // MARK: Use cases
  
  enum fetch {
      struct Request {}

      struct Response {
          let users: [UserResponse]
      }

      struct ViewModel {
          let users: [UserResponse]
      }

  }
}
