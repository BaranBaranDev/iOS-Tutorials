import UIKit



protocol DetailDisplayLogic: AnyObject {
    // func display(viewModel: DetailModels.Something.ViewModel)
}

final class DetailViewController: UIViewController {

    // MARK: Properties
    private var user: UserResponse?
    
    // MARK: UI Elements
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        return lbl
    }()

    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        return lbl
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    // MARK: - Dependencies
    typealias InteractorType = DetailBusinessLogic & DetailDataStore
    private var interactor: InteractorType
    private let router: DetailRoutingLogic

    // MARK: Initialization
    init(interactor: InteractorType, router: DetailRoutingLogic, userDataStore: UserResponse) {
        self.interactor = interactor
        self.router = router
        self.user = userDataStore
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
        configureUI()
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
    }

    // MARK: Layout
    private func layout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureUI() {
        nameLabel.text = user?.name ?? "Nil"
        emailLabel.text = user?.email ?? "Nil"
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    // Implement required methods
}
