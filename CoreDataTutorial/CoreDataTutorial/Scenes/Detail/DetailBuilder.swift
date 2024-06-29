//
//  DetailBuilder.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//


import Foundation


enum DetailBuilder {
    static func build(userDataStore: UserResponse) -> DetailViewController {
        let worker = DetailWorker()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let interactor = DetailInteractor(presenter: presenter, worker: worker)
        let vc = DetailViewController(interactor: interactor, router: router, userDataStore: userDataStore)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

