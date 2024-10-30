import UIKit

// MARK: - HomeViewDelegate Protocol
protocol HomeViewDelegate: AnyObject {
    func didClickConnectToServer()
    func didClickStartServer(port: String)
    func didClickSendMessage()
}

// MARK: - HomeView Class
final class HomeView: UIView {
    
    // MARK:  Properties
    weak var delegate: HomeViewDelegate?
    
    // MARK:  UI Elements
    
    private lazy var portTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Port numarasını girin"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var ipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "IP adresini girin"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Göndermek için mesaj girin"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Durum: Hazır"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Sunucuyu başlatan düğme.
    private lazy var startServerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sunucuyu Başlat", for: .normal)
        button.addTarget(self, action: #selector(startServer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Sunucuya bağlanma düğmesi.
    private lazy var connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sunucuya Bağlan", for: .normal)
        button.addTarget(self, action: #selector(connectToServer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Mesaj gönderme düğmesi.
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mesaj Gönder", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            portTextField,
            ipTextField,
            messageTextField,
            startServerButton,
            connectButton,
            sendMessageButton,
            statusLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: 300, height: 250)
    }
    
    // MARK: - Configure
    @MainActor
    public func configureUI(statusMessage: String? = nil) {
        statusLabel.text = statusMessage
    }
    
    // MARK: - Actions
    @objc fileprivate func connectToServer(){
        delegate?.didClickConnectToServer()
    }
    
    @objc fileprivate func startServer(){
        delegate?.didClickStartServer(port: String(describing: portTextField.text))
    }
    
    @objc fileprivate func sendMessage(){
        delegate?.didClickSendMessage()
    }
    
    // MARK: - Layout
    private func layout(){
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}

