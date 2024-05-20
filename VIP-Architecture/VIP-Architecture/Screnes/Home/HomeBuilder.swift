//
//  HomeBuilder.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import Foundation


enum HomeBuilder {
    static func build() -> HomeViewController{
        let presenter = HomePresenter()
        let worker = HomeNetworkWorker()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let router = HomeRouter()
        let controller = HomeViewController(interactor: interactor, router: router)
        
      // router.controller = controller
      // router.dataStore = interactor
        presenter.controller = controller
        return controller
    }
}
