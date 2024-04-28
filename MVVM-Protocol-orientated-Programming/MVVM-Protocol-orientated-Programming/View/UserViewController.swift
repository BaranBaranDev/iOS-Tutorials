/*
 - ViewModeli dependercy Injection ile alarak bağımlılığı azaltıyoruz böylece test edilebilir bakımı kolay kodlar yazarız.
 - Dependency injection, bir bileşenin, bağımlılıklarını başka bir bileşenden dışarıdan alarak veya enjekte edilerek oluşturulmasını sağlayan bir yazılım tasarım desenidir.
 
 -viewModel.output = self ifadesi, bir nesnenin bir başka nesneye kendisini delege etmesini sağlar. Bu durumda, viewModel nesnesi, kendisine ait bazı işlemleri veya verileri işlemek veya kullanmak üzere self olarak belirtilen başka bir nesneye (muhtemelen bir controller veya başka bir nesne) delege edilir.Örneğin, bir MVVM mimarisinde, ViewModel, kullanıcı arayüzündeki değişiklikleri yönetmek için kullanılır. Bu durumda, viewModel.output genellikle ViewModel'in çıktılarını (örneğin, veri güncellemeleri veya kullanıcı eylemleri) işlemek için bir controller'a veya başka bir nesneye atanır. Bu, ViewModel'in kullanıcı arayüzüyle etkileşimini yönetmeye ve işlemeye olanak tanır, böylece ViewModel, kullanıcı arayüzü kodundan bağımsız kalır ve yeniden kullanılabilir hale gelir.
 -
 
 */


import UIKit

final class UserViewController: UIViewController {
    
    // MARK: - UI Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchUsers()
    }
    
    // Dependercy Injection
    private let userViewModel : UserViewModel
    
    init(viewModel: UserViewModel) {
        self.userViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.output = self // delege belirleme ,
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - fetchUsers
private extension UserViewController {
    func fetchUsers() {
        userViewModel.fetchUsers()
        /*
         APIManager.shared.fetchUser { result in
         switch result {
         case .success(let user):
         if let imageUrl = URL(string: user.avatar) {
         URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
         if let data = data {
         DispatchQueue.main.async {
         self.imageView.image = UIImage(data: data)
         self.emailLabel.text = user.email
         }
         }
         }.resume()
         } else {
         self.showDefaultImageAndText()
         }
         case .failure:
         self.showDefaultImageAndText()
         }
         }
         */
    }
}


// MARK: - UserViewModelOutput

extension UserViewController: UserViewModelOutput {
 
    func uptadeView(imageURL: String, email: String) {
        
        let imageData = try! NSData(contentsOf: .init(string: imageURL)!) as Data
        self.imageView.image = UIImage(data: imageData)
        self.emailLabel.text = email
    }
    
}



// MARK: - setupViews
extension UserViewController {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 56),
            emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4)
        ])
    }
}

