//
//  HomeViewController.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit


protocol HomeDisplayLogic: AnyObject {
    func displayFetchUsers(_ viewModel: HomeModels.fetch.ViewModel)
}



final class HomeViewController: UIViewController{

    // MARK: - Properties
    private var userResponseArray : [UserResponse] = []
    
    // MARK: - UI Elements
    private lazy var tableView : UITableView = UITableView()

    //MARK: - Dependencies

    private var interactor : HomeBusinessLogic & HomeDataStore
    
    private let router : HomeRoutingLogic

    
    // MARK:  İnitialization
    
    init(interactor: HomeBusinessLogic & HomeDataStore, router: HomeRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        // istek atıldı
        interactor.fetchUsers(HomeModels.fetch.Request())
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
    private func setup() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)
    }

}


// MARK: - HomeDisplayLogic Implementation

extension HomeViewController: HomeDisplayLogic {
    func displayFetchUsers(_ viewModel: HomeModels.fetch.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.userResponseArray = viewModel.users
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

// UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userResponseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell
        else { return UITableViewCell() }
        
        let user = userResponseArray[indexPath.item]
        cell.user = user

        return cell
        
    }
}

// UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
