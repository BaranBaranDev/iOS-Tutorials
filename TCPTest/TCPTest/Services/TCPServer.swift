import Foundation
import Network

// MARK: - TCPServerDelegate Protocol

protocol TCPServerDelegate: AnyObject {
    func didReceiveMessage(_ message: String)
}

// MARK: - TCPServer Class

// TCP sunucusu, gelen bağlantıları dinler ve bu bağlantılar üzerinden gelen mesajları işler
final class TCPServer {
    
    //MARK: Private Properties
    private var listener: NWListener? // Dinleyici
    private var connections: [NWConnection] = [] // Bağlanan cihazları burada saklayalım
    
    
    // MARK:  Delegate
    weak var delegate: TCPServerDelegate?
    
    
    // MARK: Public Functions
    // Sunucuyu dışarıdan bşr port numarası alarak başlatır
    public func start(port: UInt16) {
        
        // TCP nesnesi lazım, veri aktarım,boyut ayarlama gibi işlemleride ayarlayabiliriz
        let parameters = NWParameters.tcp
        
        do {
            // Dinleyiciyi başlayıp gelen portu dinlemek lazım
            listener = try NWListener(using: parameters, on: NWEndpoint.Port(rawValue: port)!)
            
            // Bağlantı gelirse ...
            listener?.newConnectionHandler = { [weak self] connection in
                guard let self = self else { return }
                // Bağlantı dizisine ekleyelim
                self.connections.append(connection)
                
                // Gelen bağlantıyı dinlemeye başlayalım
                connection.start(queue: .main)
                
                // Mesajları alalım ve işlem sürekli
                self.receive(on: connection)
            }
            
            // NWListener sunucusunu başlat. Artık bu port üzerinde gelen bağlantıları dinliyor
            listener?.start(queue: .main)
            print("Server başlatıldı, port: \(port)")
        } catch let error {
            print("Dinleyici hatası: \(error.localizedDescription)")
        }
 
    }
    
    // MARK: Private Functions
    // Bu fonksiyon, bir NWConnection üzerinden veri almayı sağlar.Parametre olarak aktif bağlantıyı alır.
    private func receive(on connection: NWConnection){
        // connection.receive: Belirtilen bağlantıdan veri almak için kullanılır.
        // minimumIncompleteLength: Alınacak verinin minimum uzunluğu (1 byte bile olsa alacağız).
        // maximumLength: Alabileceğimiz maksimum veri miktarı (bu örnekte 1024 byte).
        
        connection.receive(minimumIncompleteLength: 1, maximumLength: 1024) { [ weak self ] content, contentContext, isComplete, error in
            guard let self = self else { return }
            
            // Eğer veri başarıyla alındıysa, bu veriyi string formatına çevirip kullanırız.
            if let data = content,
               let message = String(data: data, encoding: .utf8) {
                
                print("Mesaj alındı: \(message)")
                // Alınan mesajı geri çağırma fonksiyonu ile ana ekrana (UI) bildiriyoruz.
                delegate?.didReceiveMessage(message)
            }
            
            // Eğer bir hata yoksa, tekrar veri beklemeye devam ediyoruz.
            // Böylece bağlantı kesilene kadar veri alabiliriz.
            if error == nil {
                self.receive(on: connection)
            }
            
        }
    }
    
}

