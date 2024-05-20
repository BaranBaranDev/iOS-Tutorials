//
//  MainCoordinator.swift
//  Coordinator-Pattern
//
//  Created by Baran Baran on 20.05.2024.
//

import UIKit

// MainCoordinator sınıfı, Coordinator protokolünü uygular
class MainCoordinator: Coordinator {
    // Coordinator'lar arasında child-coordinator'ları saklamak için bir array
    var childCoordinators = [Coordinator]()
    // Uygulamanın navigation controller'ı
    var navigationController: UINavigationController
    
    // Başlatıcı (initializer) metodu, navigation controller'ı alır
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // start() metodu, koordinatörün başlangıç view controller'ını ayarlar
    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // showLogin() metodu, login ekranını gösterir
    func showLogin() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    // showRegister() metodu, register ekranını gösterir
    func showRegister() {
        let registerViewController = RegisterViewController()
        registerViewController.coordinator = self
        navigationController.pushViewController(registerViewController, animated: true)
    }
}
