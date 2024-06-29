// Amacımız test yazımını kolaylaştırmak VIPER mimarisini kullanırken.
// View katmanında, kullanıcı arayüzü işlemleri yapılır. Kullanıcının aksiyonlarını alır ve bu aksiyonda ne yapacağını Presenter’a sorar. Presenter’dan gelen çıktılara göre View’ı günceller ve kullanıcıya bunun sonucunu gösterir. (Bu butona tıklandı bu row seçildi ne yapmalıyım gibi.)


import UIKit

final class HomeVC: UIViewController {
    // MARK:  Properties
    private var userEntity: [UserEntity] = []
    
    //MARK: Dependencies
    
    weak var presenter: HomeViewPresenterInput?
    
    
    // MARK: - UI Elements
    private lazy var  tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup
    
    fileprivate func setup() {
        // subview
        view.addSubview(tableView)
        
        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reuseID)
    }
    
    
    // MARK: Layout
    fileprivate func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
// MARK: - HomeViewInputs

extension HomeVC : HomeViewInputs {
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func showItems(_ users: [UserEntity]) {
        self.userEntity = users
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEntity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseID, for: indexPath) as! HomeCell
        let user = userEntity[indexPath.item]
        cell.configure(model: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

