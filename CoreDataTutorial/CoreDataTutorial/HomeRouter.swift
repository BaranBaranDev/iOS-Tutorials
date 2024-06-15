//
//  HomeRouter.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit

protocol HomeRoutingLogic {
  
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}



final class HomeRouter:  HomeDataPassing {
    
  weak var controller: HomeViewController?
  var dataStore: HomeDataStore?

}



extension HomeRouter: HomeRoutingLogic {
    
}
