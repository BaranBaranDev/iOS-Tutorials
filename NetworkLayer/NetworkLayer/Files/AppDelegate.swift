//
//  AppDelegate.swift
//  iOS-START
//
//  Created by Baran Baran on 3.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let viewModel  = ViewModel()
        window?.rootViewController = ViewController(viewModel: viewModel)
        
        return true
    }
}

