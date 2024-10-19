//
//  TestBuilder.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.09.2024.
//


import Foundation


enum TestBuilder {
    static func build() -> TestViewController {
        let worker = TestWorker()
        let presenter = TestPresenter()
        let router = TestRouter()
        let interactor = TestInteractor(presenter: presenter, worker: worker)
        let vc = TestViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

