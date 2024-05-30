//
//  HomePageRouter.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.



import UIKit


// MARK: - HomePageRoutingLogic Protocol & HomePageDataPassing

protocol HomePageRoutingLogic {
    func routeDetailPage()
}



protocol HomePageDataPassing: AnyObject {
    // interactora girdi sağlayan protokolden gelmeli
    var dataStore: HomePageDataStore? { get }
    // get ile sadece okunması gerektiğini belirtik
}

// MARK: - HomePageRouter Class
final class HomePageRouter: HomePageDataPassing {
    
    // data passing logic
    var dataStore: HomePageDataStore?
    
    
    // viewcontroller özellikleri gerektiği için ayrıca unutma bunun referansını belirtmelisin builder kısmında mutlaka dikkat et
    weak var controller : HomePageViewController?
    
}


extension HomePageRouter: HomePageRoutingLogic{
    func routeDetailPage() {
        // DATA STORE İÇERİSİNDE GÖNDERİLECEK VERİYİ KONTROL EDELİM
        guard let model = dataStore?.userModel else { return }
        
        
        let vc = DetailPageBuilder.build(userModel: model)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
