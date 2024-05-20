//
//  HomeRouter.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import Foundation

protocol HomeRouterLogic: AnyObject {
    func goDetailsVC()
}

protocol HomeDataPassing: AnyObject {
    // Interactor'un veri saklama gereksinimlerini tanımlayan protocolden gelsin
    var dataStore: HomeDataStore?{get} // olabilir olmayabilir ve sadece okunsun
}




final class HomeRouter: HomeRouterLogic,HomeDataPassing{
    var dataStore: HomeDataStore?
    
    weak var controller: HomeViewController?
    
    
    func goDetailsVC() {
        let vc = HomeBuilder.build()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

