//
//  HomePageViewController.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.


import UIKit

// MARK:  HomePageDisplayLogic
protocol HomePageDisplayLogic: AnyObject {
    func fetchUserDisplay(viewModel: HomePage.FetchUser.ViewModel)
}

// MARK: - HomePageViewController

final class HomePageViewController: UIViewController{
    // MARK:  UI Elements
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK:  Properties
    
    private var userResArray: [UserResponse] = []
    
    //MARK:  Dependencies
    
    private let interactor : HomePageBusinessLogic
    private let router : HomePageRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: HomePageBusinessLogic, router: HomePageRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        interactor.fetchUser(request: HomePage.FetchUser.Request())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup(){
        // Add Subview
        view.addSubview(tableView)
        
        // TableView Setup Configure
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)
        
        // NavBar Setup Configure
        navigationItem.title = "User List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //
     
    }
}


// MARK: - HomePageDisplayLogic

extension HomePageViewController: HomePageDisplayLogic{
    func fetchUserDisplay(viewModel: HomePage.FetchUser.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{ return }
            self.userResArray = viewModel.users
            self.tableView.reloadData()
        }
    }
}

// MARK: -  UITableViewDelegate & UITableViewDataSource Protocol

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else{ return UITableViewCell()}
        let userModel = userResArray[indexPath.item]
        cell.configure(model: userModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.routeDetailPage()    
    }
    
}
