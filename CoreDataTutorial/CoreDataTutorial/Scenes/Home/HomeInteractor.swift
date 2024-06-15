//
//  HomeInteractor.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import Foundation

protocol HomeBusinessLogic {
    func fetchUsers(_ request: HomeModels.fetch.Request)
    
}

protocol HomeDataStore {
    var user: UserResponse? { get set }
    
}

final class HomeInteractor: HomeDataStore {
    
    // Data store logic
    var user: UserResponse?

 
    //MARK: Dependencies
    private var presenter: HomePresentationLogic?
    private var worker: HomeWorker?
    
    init(presenter: HomePresentationLogic? = nil, worker: HomeWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension HomeInteractor: HomeBusinessLogic {
    func fetchUsers(_ request: HomeModels.fetch.Request) {
        worker?.fetchUsers(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let users):
                presenter?.presentFetchUsers(HomeModels.fetch.Response(users: users))
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
}


