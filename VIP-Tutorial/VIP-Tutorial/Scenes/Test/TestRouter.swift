//
//  TestRouter.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.09.2024.



import UIKit

protocol TestRoutingLogic {
  
}

protocol TestDataPassing {
  var dataStore: TestDataStore? { get }
}



final class TestRouter:  TestDataPassing {
    
  weak var controller: TestViewController?
  var dataStore: TestDataStore?

}



extension TestRouter: TestRoutingLogic {
    
}
