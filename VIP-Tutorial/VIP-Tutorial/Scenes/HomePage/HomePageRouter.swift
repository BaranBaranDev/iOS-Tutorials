//
//  HomePageRouter.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.



import UIKit


// MARK: - HomePageRoutingLogic Protocol

protocol HomePageRoutingLogic {
    func routeDetailPage()
}


// MARK: - HomePageRouter Class
final class HomePageRouter {
    
    weak var controller : HomePageViewController?
    
}


extension HomePageRouter: HomePageRoutingLogic{
    func routeDetailPage() {
        let vc = DetailPageBuilder.build()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
