//
//  HomeVC.swift
//  MVVM
//
//  Created by Baran Baran on 25.04.2024.
//

import UIKit

final class HomeVC: UIViewController {
    // MARK: - UI Elements
    
    
    private lazy var personContainerView : UIView = {
        let vw = PersonView(){ [weak self] in
            guard let self = self else {return}
            self.sayClick()
        }
        return vw
    }()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Helper
private extension HomeVC {
    func setup(){
        configure()
    }
}

// MARK: - Actions
private extension HomeVC {
    func sayClick(){
        print("Click")
    }
}

// MARK: - Configure
private extension HomeVC {
    func configure(){
        configurePersonContainerView()
        
    }
    
    func configurePersonContainerView(){
        view.addSubview(personContainerView)
        NSLayoutConstraint.activate([
            personContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            personContainerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            personContainerView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 8))
        ])
    }
    
    
}
