//
//  HomeVC.swift
//  TCPTest
//
//  Created by Baran Baran on 24.10.2024.
//

import UIKit

final class HomeVC: UIViewController {
    // MARK: - UI Elements
    private lazy var homeView: UIView = {
        let view = HomeView()
        view.delegate  = self
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.frame = view.bounds
    }
}

// MARK: - HomeViewDelegate
extension HomeVC: HomeViewDelegate {
    func didClickConnectToServer() {
        
    }
    
    func didClickStartServer() {
        
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
