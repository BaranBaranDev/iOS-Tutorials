//
//  HomeRouter.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit

protocol HomeRoutingLogic {
  func routeDetail()
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}



final class HomeRouter:  HomeDataPassing {
    
  weak var controller: HomeViewController?
  var dataStore: HomeDataStore?

}



extension HomeRouter: HomeRoutingLogic {
    func routeDetail() {
        guard let user = dataStore?.user else { return }
        
        let rootVC = DetailBuilder.build(userDataStore: user)
        controller?.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    
}
