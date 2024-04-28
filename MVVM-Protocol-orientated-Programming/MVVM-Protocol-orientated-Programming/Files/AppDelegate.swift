//
//  AppDelegate.swift
//  MVVM-Protocol-orientated-Programming
//
//  Created by Baran Baran on 28.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let userService : UserServiceProtocol = APIManager()
        let viewModel  = UserViewModel(service: userService)
        window?.rootViewController = UserViewController(viewModel: viewModel)
        return true
    }

}

