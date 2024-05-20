//
//  Coordinator.swift
//  Coordinator-Pattern
//
//  Created by Baran Baran on 20.05.2024.
//

import UIKit


//Coordinator pattern, uygulamanızdaki navigasyon ve akış kontrolünü merkezi bir koordinatör sınıfına devrederek bu sınıfların karmaşıklığını azaltır.

//Bu protokol, her coordinator'ın sahip olması gereken temel işlevselliği belirler.
protocol Coordinator {
    // var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController{ get set }
    // func start()
}
