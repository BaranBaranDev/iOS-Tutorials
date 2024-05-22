//
//  HomeViewController.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import UIKit


// HomeDisplayLogic protokolü, HomeViewController'ın implement edeceği metodları tanımlar
protocol HomeDisplayLogic: AnyObject {
    func displayUsers(viewModel: HomeModels.FetchUsers.viewmodel)
    
}


final class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    // MARK: - Properties
    
    private var users: [HomeModels.UserViewModel] = [] // UserViewModel array'i
    
    //MARK: - Dependencies
    
    private let interactor : HomeBusinessLogic
    
    
    init(interactor: HomeBusinessLogic){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        interactor.fetchUsers(request: HomeModels.FetchUsers.request())

    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK:  - Setup
    
    private func setup(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)
    }
    
}



// MARK: - HomeDisplayLogic Protocol

extension HomeViewController: HomeDisplayLogic {
    // Presenterdan gelen kullanıcı verilerini gösterir
    func displayUsers(viewModel: HomeModels.FetchUsers.viewmodel) {
        users = viewModel.users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: -  UITableViewDelegate & UITableViewDataSource Protocol
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else{ return UITableViewCell()}
        let user = users[indexPath.item]
        cell.user = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}


// MARK: - Layout

private extension HomeViewController{
    func layout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
