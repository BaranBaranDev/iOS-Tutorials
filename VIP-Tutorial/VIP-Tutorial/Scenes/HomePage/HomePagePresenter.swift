//
//  HomePagePresenter.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//


import UIKit

// MARK: - HomePagePresentationLogic

// interactordan alınanlar dşyelim
protocol HomePagePresentationLogic {
    func presentFetchUser(response: HomePage.FetchUser.Response)
}


// MARK: - HomePagePresenter

final class HomePagePresenter {
    // controller a ulaşmamız lazım ki presentardan viewa viewmodel ile aktaralım
    weak var controller: HomePageDisplayLogic?
}



extension HomePagePresenter: HomePagePresentationLogic {
    func presentFetchUser(response: HomePage.FetchUser.Response) {
        controller?.fetchUserDisplay(viewModel: HomePage.FetchUser.ViewModel(users: response.users))
    }
}
