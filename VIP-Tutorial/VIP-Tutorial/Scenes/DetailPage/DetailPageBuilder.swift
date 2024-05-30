//
//  DetailPageBuilder.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.05.2024.
//

import Foundation


enum DetailPageBuilder{
    static func build(userModel: UserResponse) -> DetailPageViewController {
        let vc = DetailPageViewController(people: userModel)
        
        return vc
    }
}
