//
//  HomeModels.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation


// HomeModels enum'u, Home modülü için gerekli veri modellerini içerir
enum HomeModels{
    
    // UserViewModel, ViewController'da gösterilecek kullanıcı verilerini içerir
    struct UserViewModel {
        let name: String
    }
    
    // FetchUsers, kullanıcı verilerini çekmek için gerekli modelleri içerir
    enum FetchUsers {
        
        // Veri çekme olacağından request gerekmiyor
        struct request {} // view dan interactora
        
        struct response {
            // interactordan presentera gönderilecek
            let users: [UserResponse]
            
        }
        
        struct viewmodel {
            // presenterın view'a yollayacakları
            let users: [UserViewModel]
        }
    }
}
