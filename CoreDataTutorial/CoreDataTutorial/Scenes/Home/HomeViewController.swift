//
//  HomeViewController.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.



import UIKit


// MARK: - HomeDisplayLogic
protocol HomeDisplayLogic: AnyObject {
    func displayFetchUsers(_ viewModel: HomeModels.fetch.ViewModel)
}


// MARK: - HomeViewController
final class HomeViewController: UIViewController{

    // MARK:  Properties
    private var userResponseArray : [UserResponse] = []
    
    // MARK: - UI Elements
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    

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
        layout()
    }

    
    // MARK: - Setup
    private func setup() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
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
        
        let model = userResponseArray[indexPath.item]
        cell.configure(model)
        return cell
        
    }
}

// UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // gönderilecek datanın içini dolduralım
        let user = userResponseArray[indexPath.item]
        interactor.user = user
        
        
        router.routeDetail()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



#Preview {
    MainVC()
}
