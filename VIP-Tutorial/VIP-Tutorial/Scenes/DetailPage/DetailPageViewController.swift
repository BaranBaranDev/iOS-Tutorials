//
//  DetailPageViewController.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.05.2024.

import UIKit

final class DetailPageViewController: UIViewController{
    
    // MARK:  Properties
    private var people : UserResponse? // bunu dışarıdan dependency injection ile alacağız
    
    // MARK:  İnitialization
    init(people: UserResponse? = nil) {
        self.people = people
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = people?.email ?? "Nil"
        
    }
    
}

