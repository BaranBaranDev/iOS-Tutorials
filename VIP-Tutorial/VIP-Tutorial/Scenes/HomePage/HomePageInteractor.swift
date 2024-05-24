//
//  HomePageInteractor.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.



import Foundation

// MARK: - HomePageBusinessLogic

protocol HomePageBusinessLogic {
    func fetchUser(request: HomePage.FetchUser.Request)
}


// MARK: - HomePageInteractor
final class HomePageInteractor {
    
    //MARK: Dependencies

    private let networkWorker: NetworkWorkerProtocol
    private let presenter: HomePagePresentationLogic
    
    // MARK:  İnitialization
    
    init(networkWorker: NetworkWorkerProtocol, presenter: HomePagePresentationLogic) {
        self.networkWorker = networkWorker
        self.presenter = presenter
    }
}


extension HomePageInteractor: HomePageBusinessLogic{
    func fetchUser(request: HomePage.FetchUser.Request) {
        networkWorker.getUsers {[weak self] result in
            guard let self = self else{ return }

            switch result{
            case .success(let userResponse):
                presenter.presentFetchUser(response: HomePage.FetchUser.Response(users: userResponse))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
