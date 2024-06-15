//
//  DetailInteractor.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import Foundation

protocol DetailBusinessLogic {
    
    
}

protocol DetailDataStore {
    //var name: String { get set }
    
}

final class DetailInteractor: DetailDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private var presenter: DetailPresentationLogic?
    private var worker: DetailWorker?
    
    init(presenter: DetailPresentationLogic? = nil, worker: DetailWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension DetailInteractor: DetailBusinessLogic {
    
}


