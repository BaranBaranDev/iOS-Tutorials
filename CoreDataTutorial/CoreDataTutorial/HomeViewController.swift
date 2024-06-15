//
//  HomeViewController.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit


protocol HomeDisplayLogic: AnyObject {
    
}



final class HomeViewController: UIViewController{

    // MARK: - Properties
    
    
    // MARK: - UI Elements
    

    //MARK: - Dependencies

    private var interactor : HomeBusinessLogic & HomeDataStore
    
    private let router : HomeRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: HomeBusinessLogic & HomeDataStore, router: HomeRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
    }
 
    
    // MARK: - Setup
    private func setup() {
    }
    
    // MARK: Layout
    private func layout() {
        
    }
}


// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {

}
