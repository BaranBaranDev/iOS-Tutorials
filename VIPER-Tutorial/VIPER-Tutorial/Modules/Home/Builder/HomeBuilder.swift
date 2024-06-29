//
//  HomeBuilder.swift
//  VIPER-Tutorial
//
//  Created by Baran Baran on 29.06.2024.
//

import Foundation


enum HomeBuilder {
    static func build() -> HomeVC {
       
        let vc = HomeVC()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: vc, interactor: interactor)
        
        vc.presenter = presenter  
        interactor.presenter = presenter
        
        return vc
    }
}
