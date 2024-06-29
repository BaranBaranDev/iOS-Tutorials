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
        let service = ServiceManager()
        let interactor = HomeInteractor(service: service)
        let presenter = HomePresenter(interactor: interactor)
        
        // ref belirtme
        
        vc.presenter = presenter
        interactor.presenter = presenter
        presenter.view = vc
        
        
        
        return vc
    }
}
