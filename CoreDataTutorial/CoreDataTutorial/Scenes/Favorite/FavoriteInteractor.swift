//
//  FavoriteInteractor.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 1.08.2024.



import Foundation

protocol FavoriteBusinessLogic {
    
    
}

protocol FavoriteDataStore {
    //var name: String { get set }
    
}

final class FavoriteInteractor: FavoriteDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private var presenter: FavoritePresentationLogic?
    private var worker: FavoriteWorker?
    
    init(presenter: FavoritePresentationLogic? = nil, worker: FavoriteWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension FavoriteInteractor: FavoriteBusinessLogic {
    
}


