//
//  AppDelegate.swift
//  Coordinator-Pattern
//
//  Created by Baran Baran on 20.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Ana pencere
    var window: UIWindow?
    // Ana Coordinator referansı
    var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // UINavigationController oluştur
        let navigationController = UINavigationController()
        
        // MainCoordinator'ı başlat ve navigationController'ı geçir
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        
        // Uygulama penceresini oluştur ve ayarla
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
