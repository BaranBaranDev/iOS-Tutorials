//
//  HomeVC.swift
//  TCPTest
//
//  Created by Baran Baran on 24.10.2024.
//

import UIKit

// MARK: - HomeVC
final class HomeVC: UIViewController {
    
    // MARK:  Properties
    private let server = TCPServer()
    private let client = TCPClient()
    
    // MARK: - UI Elements
    private lazy var homeView: UIView = {
        let view = HomeView()
        view.delegate  = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.center = view.center

    }
    
    // MARK: - Setup
    private func setup(){
        view.addSubview(homeView)
    }
}

// MARK: - HomeViewDelegate
extension HomeVC: HomeViewDelegate {
    func didClickStartServer(port: String) {
        print(port)
    }
    
    func didClickConnectToServer() {
        
    }

    
    func didClickSendMessage() {
        
    }
    
}
#Preview {
    HomeVC()
}

/*
 ┌──────────────────────┐         ┌────────────────────────────┐
 │                      │         │                            │
 │  HomeViewController  │         │       TCPServer           │
 │ (UI)                 │         │  (Sunucu)                 │
 │                      │         │                            │
 │ 1. startServer()     │         │                            │
 │    - Server'ı başlat │         │   2. NWListener           │
 │                      │◀────────┤    - TCP bağlantısı       │
 │ 3. delegate          │         │      başlatılıyor         │
 │    - didReceiveMessage()       │                            │
 │    - delegate üzerinden        │   4. receive()            │
 │      mesaj alınır.             │      - Mesaj alındığında  │
 │                      │         │        delegate çağrılır  │
 └──────────┬───────────┘         └──────────────┬────────────┘
 │                                     │
 │                                     │
 │                                     │
 ┌────▼──────────────────────┐         ┌────▼────────────────────────────┐
 │                           │         │                                 │
 │         TCPClient         │         │       TCPServerDelegate         │
 │ (İstemci)                 │         │      - didReceiveMessage()      │
 │                           │         │      - Sunucu mesaj aldığında   │
 │ 5. connect()              │         │        ViewController’a veri    │
 │     - Sunucuya bağlan     │         │        gönderir                │
 │                           │         │                                 │
 │ 6. send(message)          │         └─────────────────────────────────┘
 │     - Mesaj gönderilir    │
 └───────────────────────────┘
 
 */
