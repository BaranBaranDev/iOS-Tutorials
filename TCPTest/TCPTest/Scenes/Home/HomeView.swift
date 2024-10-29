import UIKit

// MARK: - HomeViewDelegate Protocol
protocol HomeViewDelegate: AnyObject {
    func didClickConnectToServer()
    func didClickStartServer()
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
        return textField
    }()
    
    private lazy var ipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "IP adresini girin"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Göndermek için mesaj girin"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Durum: Hazır"
        label.textAlignment = .center
        return label
    }()
    
    // Sunucuyu başlatan düğme.
    private lazy var startServerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sunucuyu Başlat", for: .normal)
        button.addTarget(self, action: #selector(startServer), for: .touchUpInside)
        return button
    }()
    
    // Sunucuya bağlanma düğmesi.
    private lazy var connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sunucuya Bağlan", for: .normal)
        button.addTarget(self, action: #selector(connectToServer), for: .touchUpInside)
        return button
    }()
    
    // Mesaj gönderme düğmesi.
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mesaj Gönder", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
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
    
    // MARK: - Actions
    @objc fileprivate func connectToServer(){
        delegate?.didClickConnectToServer()
    }
    
    @objc fileprivate func startServer(){
        delegate?.didClickStartServer()
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

