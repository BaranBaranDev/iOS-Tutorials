//
//  HomeBuilder.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//


import Foundation


enum HomeBuilder {
    static func build() -> HomeViewController {
        let worker = HomeWorker()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let vc = HomeViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

