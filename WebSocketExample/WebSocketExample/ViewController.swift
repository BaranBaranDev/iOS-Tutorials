//
//  ViewController.swift
//  WebSocketExample
//
//  Created by Baran Baran on 19.10.2024.
//

import UIKit

// ViewController sınıfı, URLSessionWebSocketDelegate protokolünü implemente ediyor.
class ViewController: UIViewController, URLSessionWebSocketDelegate {
    // MARK: - Özellikler (Properties)
    // WebSocket bağlantısını tutacak değişken
    private var webSocket: URLSessionWebSocketTask?
    
    // MARK: - UI Elemanları
    // Kapat butonu tanımlanıyor
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal) // Butonun başlığı "Close" olarak ayarlanıyor
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 100) // Butonun boyutu belirleniyor
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout'u elle ayarlamak için
        return button
    }()
    
    // MARK: - Yaşam Döngüsü (LifeCycle)
    override func viewDidLoad() {
        super.viewDidLoad()
        // ViewController'ın görünümü yüklendiğinde setup() metodunu çağırıyoruz.
        setup()
    }
    
    // MARK: - Kurulum (Setup)
    // ViewController'ın başlangıç ayarlarını yapan metod
    private func setup(){
        view.addSubview(closeButton) 
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // "close" metoduna buton tıklamasını ilişkilendiriyoruz.
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        // WebSocket için bir URLSession oluşturuluyor
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        // WebSocket URL'si belirleniyor (Piesocket Demo URL'si)
        let url = URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")
        // WebSocket görevi başlatılıyor
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume() // WebSocket bağlantısı başlatılıyor
    }
    
    // WebSocket üzerinden ping mesajı gönderiliyor
    private func ping(){
        webSocket?.sendPing(pongReceiveHandler: { error in
            // Eğer hata varsa hatayı yazdırıyoruz
            if let error = error {
                print("Ping hatası: \(error.localizedDescription)")
            } else {
                print("Ping gönderildi")
            }
        })
    }
    
    // WebSocket bağlantısını kapatmak için metod
    @objc private func close(){
        // WebSocket "goingAway" sebebiyle kapatılıyor
        webSocket?.cancel(with: .goingAway, reason: "Project End".data(using: .utf8))
        print("WebSocket kapatıldı")
    }
    
    // WebSocket üzerinden mesaj göndermek için metod
    private func send(){
        // Mesaj gönderimi için 1 saniye gecikmeli asenkron bir işlem yapılıyor
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return } // ViewController'ın varlığını kontrol ediyoruz
            self.send() // Döngüsel olarak bu metodu çağırıyoruz
            // WebSocket ile rastgele bir mesaj gönderiyoruz
            self.webSocket?.send(.string("Send new message \(Int.random(in: 0...100))"), completionHandler: { error in
                if let error = error {
                    print("Mesaj gönderim hatası: \(error.localizedDescription)") // Hata varsa yazdırılıyor
                } else {
                    print("Mesaj başarıyla gönderildi") // Hata yoksa başarı mesajı yazdırılıyor
                }
            })
        }
    }
    
    // WebSocket üzerinden mesaj almak için metod
    private func receive(){
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            // Mesaj başarılı şekilde alındı
            case .success(let message):
                switch message {
                // Mesaj data formatında geldiyse
                case .data(let data):
                    print("Veri alındı: \(data)")
                // Mesaj string formatında geldiyse
                case .string(let message):
                    print("Mesaj alındı: \(message)")
                @unknown default:
                    break
                }
            // Mesaj alımı sırasında bir hata olduysa
            case .failure(let error):
                print("Mesaj alma hatası: \(error.localizedDescription)")
            }
            // Sürekli mesaj alımını devam ettirmek için tekrar receive() çağırıyoruz
            self?.receive()
        })
    }
    
    // MARK: - URLSessionWebSocketDelegate
    // WebSocket bağlantısı açıldığında tetiklenen metod
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Socket bağlantısı açıldı")
        ping()   // Ping gönderiliyor
        receive() // Mesaj alımına başlıyoruz
        send()    // Mesaj göndermeye başlıyoruz
    }
    
    // WebSocket bağlantısı kapandığında tetiklenen metod
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Bağlantı kapatıldı sebep: \(String(describing: reason))")
    }
}

#Preview {
    ViewController()
}
