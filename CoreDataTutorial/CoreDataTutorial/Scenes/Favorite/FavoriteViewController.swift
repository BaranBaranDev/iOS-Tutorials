//
//  FavoriteViewController.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 1.08.2024.



import UIKit


protocol FavoriteDisplayLogic: AnyObject {
    
    // func display(viewModel: FavoriteModels.Something.ViewModel)
}



final class FavoriteViewController: UIViewController{

    // MARK: - Properties
    private let textName: String = "Hello"
    
    // MARK: - UI Elements
    private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 35)
        return lbl
    }()

    //MARK: - Dependencies

    private var interactor : FavoriteBusinessLogic & FavoriteDataStore
    
    private let router : FavoriteRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: FavoriteBusinessLogic & FavoriteDataStore, router: FavoriteRoutingLogic) {
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
        fetchUserData()
        
    }
 
    
    // MARK: - Setup
    private func setup() {
        // addSubview
        view.addSubview(nameLabel)
        
        // change
        nameLabel.text = textName
        
    }
    
    // MARK: Layout
    private func layout() {
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    private func fetchUserData(){
        let users: [UserDatabase] = CoreDataManager.shared.fetch(UserDatabase.self)
        for user in users {
            nameLabel.text = user.name
        }
    }
    
    
}


// MARK: - FavoriteDisplayLogic

extension FavoriteViewController: FavoriteDisplayLogic {

}


// MARK: - Preview
#Preview {
    FavoriteBuilder.build()
}
