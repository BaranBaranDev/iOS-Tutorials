//
//  HomePageModels.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//


import UIKit
// Burasını kodun daha temiz durması için oluşturulan ara bir konum olarak dşünebilirsin Buna Models deriz 
enum HomePage{
    enum FetchUser{
        // viewın interactora göndermesi gerekn bir şey varsa burada
        struct Request {}
        
        // interactorun dönütü presentara daha doğrusu öyle düşün
        struct Response {
            let users: [UserResponse]
        }
        
        // presentaradan view a düşün ve son düzenlemeler burada yapılır  mesela nsattributedstring gibi daha temiz olması için işleyeceğin verileri bir struct içerisinde barındırıp onu da verebilirsin.
        struct ViewModel{
            let users: [UserResponse]
        }
        
    }
}
