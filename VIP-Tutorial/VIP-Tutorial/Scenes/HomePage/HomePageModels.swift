//
//  HomePageModels.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//


import UIKit

enum HomePage{
    enum FetchUser{
        struct Request {}
        struct Response {
            let users: [UserResponse]
        }
        struct ViewModel{
            let users: [UserResponse]
        }
        
    }
}
