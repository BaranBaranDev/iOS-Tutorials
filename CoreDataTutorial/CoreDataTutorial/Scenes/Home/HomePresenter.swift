//
//  HomePresenter.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//


import UIKit

protocol HomePresentationLogic {
    func presentFetchUsers(_ response: HomeModels.fetch.Response)
}



final class HomePresenter {
  weak var controller: HomeDisplayLogic?
  
  
}



extension HomePresenter: HomePresentationLogic {
    func presentFetchUsers(_ response: HomeModels.fetch.Response) {
        controller?.displayFetchUsers(HomeModels.fetch.ViewModel(users: response.users))
    }
}
