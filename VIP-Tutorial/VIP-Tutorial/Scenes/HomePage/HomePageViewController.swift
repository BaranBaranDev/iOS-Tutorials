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
    

    private var interactor : HomePageBusinessLogic & HomePageDataStore // bunları typealies yapısına da alabilsin bence daha temiz olur ek bilgi olsun :)
    
    private let router : HomePageRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: HomePageBusinessLogic & HomePageDataStore, router: HomePageRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        // Başlar başlamaz ekranda verilerin gelmesi için interactora istek atılır . Eğer query gibi bir şey gönderilmesi gerekiyorsa burada Request içerisine belirtilerek gönderim sağlanır ama şuan ihtiyacımız olmadığından gerek yok istek atmamız yeterli
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
        
        // gönderilecek daha için interactora ulaşaım
        interactor.userModel = userResArray[indexPath.item]
        
        // sayfa geçişi burada ya aynı şekil öncesainde aktarılacak veriyi de belirtelim
        router.routeDetailPage()
    }
    
}
