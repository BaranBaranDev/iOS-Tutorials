//
//  HomePresenter.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation


import Foundation

// HomePresentationLogic protokolü, HomePresenter'ın implement edeceği metodları tanımlar
protocol HomePresentationLogic {
    func presentFetchedUsers(response: HomeModels.FetchUsers.response)
}

// HomePresenter, verileri formate eder ve ViewController'a sunar
final class HomePresenter {
    weak var viewController: HomeDisplayLogic? // builder de belirttim :)
    
}


extension HomePresenter: HomePresentationLogic{
    func presentFetchedUsers(response: HomeModels.FetchUsers.response) {

        // UserResponse tipindeki kullanıcı verilerini UserViewModel'e dönüştürüyoruz.
        let users = response.users.map{HomeModels.UserViewModel(name: $0.name)}
   
        // Dönüştürülmüş kullanıcı verilerini FetchUsers ViewModel'i içine yerleştiriyoruz.
        let viewModel = HomeModels.FetchUsers.viewmodel(users: users)
        
        // ViewController'a işlenmiş kullanıcı verilerini gönderiyoruz.
        viewController?.displayUsers(viewModel: viewModel)

    }
    
    
}
