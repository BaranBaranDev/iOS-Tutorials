//
//  TestViewController.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 24.09.2024.



import UIKit


protocol TestDisplayLogic: AnyObject {
    
   // func display(viewModel: TestModels.Something.ViewModel)
}



final class TestViewController: UIViewController{

    // MARK: - Properties
    
    
    // MARK: - UI Elements
    

    //MARK: - Dependencies

    private var interactor : TestBusinessLogic & TestDataStore
    
    private let router : TestRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: TestBusinessLogic & TestDataStore, router: TestRoutingLogic) {
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


// MARK: - TestDisplayLogic

extension TestViewController: TestDisplayLogic {

}
