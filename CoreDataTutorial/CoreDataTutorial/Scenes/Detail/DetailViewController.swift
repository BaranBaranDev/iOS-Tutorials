//
//  DetailViewController.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit


protocol DetailDisplayLogic: AnyObject {
    
    func display(viewModel: DetailModels.Something.ViewModel)
}



final class DetailViewController: UIViewController{

    // MARK: - Properties
    
    
    // MARK: - UI Elements
    

    //MARK: - Dependencies

    private var interactor : DetailBusinessLogic & DetailDataStore
    
    private let router : DetailRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: DetailBusinessLogic & DetailDataStore, router: DetailRoutingLogic) {
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


// MARK: - DetailDisplayLogic

extension DetailViewController: DetailDisplayLogic {

}
