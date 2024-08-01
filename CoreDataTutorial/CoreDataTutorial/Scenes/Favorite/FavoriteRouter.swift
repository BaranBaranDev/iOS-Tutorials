//
//  FavoriteRouter.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 1.08.2024.



import UIKit

protocol FavoriteRoutingLogic {
  
}

protocol FavoriteDataPassing {
  var dataStore: FavoriteDataStore? { get }
}



final class FavoriteRouter:  FavoriteDataPassing {
    
  weak var controller: FavoriteViewController?
  var dataStore: FavoriteDataStore?

}



extension FavoriteRouter: FavoriteRoutingLogic {
    
}
