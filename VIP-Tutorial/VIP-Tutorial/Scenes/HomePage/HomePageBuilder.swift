//
//  HomePageBuilder.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//

import Foundation


enum HomePageBuilder {
    static func build() -> HomePageViewController {
        let worker = HomePageWorker()
        let presenter = HomePagePresenter()
        let router = HomePageRouter()
        let interactor = HomePageInteractor(networkWorker: worker, presenter: presenter)
        let vc = HomePageViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc  
        return vc
        
    }
}
