//
//  HomeInteractor.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation // UIKit  kesinlikle import edilmemelidir.


// MARK: - HomeBusinessLogic Protocol

// HomeBusinessLogic protokolü, HomeInteractor'ın implement edeceği metodları tanımlar
protocol HomeBusinessLogic{
    func fetchUsers(request: HomeModels.FetchUsers.request)
}



// MARK: - HomeInteractor Protocol
// HomeInteractor, iş mantığını ve iş kurallarını içerir, veri işleme ve ağ çağrıları gibi işlemleri yapar

final class HomeInteractor{
    private let worker: NetworkWorkerProtocol
    private let presenter: HomePresentationLogic
    
    init(worker: NetworkWorkerProtocol, presenter: HomePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}


extension HomeInteractor: HomeBusinessLogic{
    @MainActor
    func fetchUsers(request: HomeModels.FetchUsers.request) {
        worker.getUsers {[weak self] result in
            guard let self = self else{ return }
            switch result{
            case .success(let users):
                // Gelen decode edilmiş veriyi presentera yollamamız lazım
                let response = HomeModels.FetchUsers.response(users: users)
                // API'den gelen verileri presenter'a gönderir
                self.presenter.presentFetchedUsers(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
