//
//  ViewController.swift
//  Coordinator-Pattern
//
//  Created by Baran Baran on 20.05.2024.
//



import UIKit

class MainViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    private lazy var loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("LOGIN", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        return btn
    }()
    
    private lazy var registerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("REGISTER", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tappedRegister), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    // MARK: - Actions
    
    @objc fileprivate func tappedLogin(){
        coordinator?.showLogin()
    }
    
    @objc fileprivate func tappedRegister(){
        coordinator?.showRegister()
    }
    
    
    
    // MARK: - Layout
    private func layout(){
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

