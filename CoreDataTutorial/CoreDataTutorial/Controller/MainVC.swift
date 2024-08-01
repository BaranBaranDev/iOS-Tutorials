//
//  MainVC.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 23.07.2024.
//


import UIKit

final class MainVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: - Helpers

extension MainVC {
    private func setup() {
        let homeVC = createViewController(rootVC: HomeBuilder.build(), title: "Home", image: "house")
        let favoriVC = createViewController(rootVC: FavoriteBuilder.build(), title: "Favorite", image: "star")

        viewControllers = [homeVC, favoriVC]
  
        customizeTabBar()
        customizeNavigationBar()
    }
    
   
    private func createViewController(rootVC: UIViewController, title: String, image: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: rootVC)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        rootVC.title = title
        
        return controller
    }
    
    private func customizeTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
}
