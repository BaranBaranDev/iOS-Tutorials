//
//  HomeBuilder.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import UIKit

enum HomeBuilder{
    static func build() -> HomeViewController {
        let worker = NetworkWorker()
        let presenter = HomePresenter()
        
        let interactor = HomeInteractor(worker: worker, presenter: presenter)
        let vc = HomeViewController(interactor: interactor)
        
        // önemli :
        presenter.viewController = vc
        return vc
    }
}
