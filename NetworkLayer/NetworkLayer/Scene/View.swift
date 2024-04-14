// final alırsa class o class farklı bir yere uygulanmayacağını belirtiyor
// MVVM biz protocollerle bind edeceğiz.
// View da ui , viewModel de aksiyonlarımız amacımız viewControlleri şişirmemek bu sayede bölerek büyümesini engelleriz.
// protocollerimizi oluşturalım ne yapaağımıza onlarla karar verelim.
// İlk başta temel methodları aktar mesela viewDidLoad
// ViewModel da ki protokolle yetkilendirirken isimlendirmeyi viewControllerda ki  içeriğe göre yaparız karışıklık olmaması için view da ise sen belirlersin viewModel olarak prepareTableView mesela delege işlemlerini burada tutacağım tableView için ..
// Şimdi viewModel da ki viewdidLoad ulaşmak için viewModel classımızdan nesne oluşturalım
// ViewInterface buraya uyarlanmıştı ve buradan view oluşturuldu ViewModelda ikisi arasında ki bind viewModel.view = self yani viewın benim diyerek sağlıyacağız
// Dependency injection, bir bileşenin, diğer bileşenlerin ihtiyaç duyduğu bağımlılıkları dışarıdan alarak veya enjekte edilerek oluşturulmasını sağlayan bir tasarım desenidir.


import UIKit

protocol ViewInterface: AnyObject {
    func prepareTableView()
    func reloadData()
    
    
}

final class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView : UITableView = UITableView()
    
    
    // MARK: - Properties
    
    // private lazy var viewModel = ViewModel()
    // daha test edilebilir olması için üst satır yerine bunu tercih ettim. Böylece dışarıdan veriyoruz
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        setupUI()
    }
    // MARK: - Helpers
    private func setupUI(){
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    
}



// MARK: - UITableViewDelegate && UITableViewDataSource
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let users = viewModel.usersArray[indexPath.row]
        cell.textLabel?.text = users.name
        return cell
    }
    
}
// MARK: - HomeVCInterface Protokolü
extension ViewController: ViewInterface{
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    

    
    
}


// MARK: - Configure

extension ViewController: Subviewsable {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }
    
    private func configureTableView(){
        addSubviews(tableView)
        
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.rightAnchor.constraint(equalToSystemSpacingAfter: tableView.rightAnchor, multiplier: 1).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1).isActive = true
    }
}

