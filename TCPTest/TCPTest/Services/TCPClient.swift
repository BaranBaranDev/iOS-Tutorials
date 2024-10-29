import Foundation
import Network


// MARK: - TCPClient Class
// Bu sınıf, bir sunucuya bağlanır ve sunucuya mesaj gönderir.
final class TCPClient {
    //MARK: Private Properties
    // Bağlantıyı temsil eden NWConnection nesnesi.
    private var connection: NWConnection?
    
    
    // MARK: Public Functions
    // Sunucuya bağlanma fonksiyonu.
    // Parametre olarak sunucunun IP adresi (host) ve port numarasını alır.
    public func connect(to host: String, port: UInt16) {
        // TCP protokolü kullanılarak bağlantı parametreleri ayarlanır.
        let parameters = NWParameters.tcp
        
        // NWConnection ile sunucuya (host) ve port numarasına bağlanıyoruz.
        connection = NWConnection(host: NWEndpoint.Host(host), port: NWEndpoint.Port(rawValue: port)!, using: parameters)
        
        // Bağlantı durumu güncellendiğinde tetiklenen fonksiyon.
        // NWConnection durumu "ready", "failed" gibi durumlardan birine geçebilir.
        connection?.stateUpdateHandler = { state in
            switch state {
                // Bağlantı başarılıysa bu case tetiklenir.
            case .ready:
                print("Bağlantı başarılı.")
                // Bağlantı başarısız olduysa burada hatayı yakalarız.
            case .failed(let error):
                print("Bağlantı hatası: \(error)")
            default:
                break
            }
        }
        // Bağlantıyı başlatıyoruz.
        connection?.start(queue: .main)
    }
    
    // Sunucuya mesaj gönderen fonksiyon.
    // Parametre olarak gönderilecek mesajı alır.
    func send(message: String) {
        // Gönderilecek mesajı UTF-8 formatında byte verisine çeviriyoruz.
        let data = message.data(using: .utf8)
        // connection.send: Bağlantı üzerinden veriyi gönderir.
        connection?.send(content: data, completion: .contentProcessed { error in
            // Eğer gönderim sırasında bir hata oluşursa, bu hatayı yakalarız.
            if let error = error {
                print("Mesaj gönderim hatası: \(error)")
            } else {
                // Mesaj başarıyla gönderildi.
                print("Mesaj gönderildi: \(message)")
            }
        })
    }
}

