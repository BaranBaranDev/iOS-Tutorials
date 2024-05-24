//
//  HomePagePresenter.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//


import UIKit

// MARK: - HomePagePresentationLogic

protocol HomePagePresentationLogic {
    func presentFetchUser(response: HomePage.FetchUser.Response)
}

// MARK: - HomePagePresenter

final class HomePagePresenter {
    
    weak var controller: HomePageDisplayLogic?
}



extension HomePagePresenter: HomePagePresentationLogic {
    func presentFetchUser(response: HomePage.FetchUser.Response) {
        controller?.fetchUserDisplay(viewModel: HomePage.FetchUser.ViewModel(users: response.users))
    }
}
