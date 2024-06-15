//
//  DetailRouter.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit

protocol DetailRoutingLogic {
  
}

protocol DetailDataPassing {
  var dataStore: DetailDataStore? { get }
}



final class DetailRouter:  DetailDataPassing {
    
  weak var controller: DetailViewController?
  var dataStore: DetailDataStore?

}



extension DetailRouter: DetailRoutingLogic {
    
}
