//
//  HomeInteractor.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import Foundation

protocol HomeBusinessLogic {
    
    
}

protocol HomeDataStore {
    //var name: String { get set }
    
}

final class HomeInteractor: HomeDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private var presenter: HomePresentationLogic?
    private var worker: HomeWorker?
    
    init(presenter: HomePresentationLogic? = nil, worker: HomeWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension HomeInteractor: HomeBusinessLogic {
    
}


