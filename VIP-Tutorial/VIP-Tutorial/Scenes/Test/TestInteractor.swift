//
//  TestInteractor.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.09.2024.



import Foundation

protocol TestBusinessLogic {
    
    
}

protocol TestDataStore {
    //var name: String { get set }
    
}

final class TestInteractor: TestDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private var presenter: TestPresentationLogic?
    private var worker: TestWorker?
    
    init(presenter: TestPresentationLogic? = nil, worker: TestWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension TestInteractor: TestBusinessLogic {
    
}


