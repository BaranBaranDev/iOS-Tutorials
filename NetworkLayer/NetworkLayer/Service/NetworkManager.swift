//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Baran Baran on 3.04.2024.
//

import Foundation

// https://jsonplaceholder.typicode.com/users
// Hataları özelleştirelim Error protokolünü barındıran NetworkError adında bir enum oluşturduk
// NetworkManagerde olmasını istediğim yetkileri NetworkManagerProtocol oluşturalım daha sonra dahil ederiz.
/*
 -- func request(_ endpoint: EndPoint, completion: @escaping(Result<Data,NetworkError>) -> Void)
 - Oluşturduğumuz EndPoint alsın
 - Sonucu döndürmek için completion: @escaping(Result<Data,NetworkError>) -> Void kullanıyoruz
 * Bu metod, belirli bir EndPoint nesnesi alır ve bu endpoint için bir ağ isteği yapar. İstek tamamlandığında, sonucu Result tipindeki bir kapanış (closure) ile döndürür. Result tipi, isteğin başarılı olduğu durumda veri (data) veya bir ağ hatası (NetworkError) içerebilir. Bu kapanış, ağ isteğinin sonucunu işlemek ve kullanıcıya bildirmek için kullanılır.
 
 * Bu sınıf, ağ isteklerini yönetmek için bir arayüz sağlar. shared adında bir static özellik tanımlandık ve bu özellik aracılığıyla NetworkManager sınıfının bir örneğine erişim sağlanır. shared özelliği, singleton tasarım desenini uygular. singleton tasarım deseni, bir sınıfın yalnızca bir örneğine sahip olmasını sağlayarak, uygulama boyunca bu örneğe kolayca erişim sağlar. private init(){} diyerek de tekrar tekrar oluşturulmasının önüne geçiyoruz
 
 // Generic yapı olması için Codable destekleyen ResponseType dedik bazı yerde T type diye de geçer anlaşılır olması için isim verdik. Daha sonra URLSessions ile istek attık veriyi completion koyup ilettik..
 
 */

// MARK: - NetworkError
enum NetworkError: Error {
    case unableToComplete
    case invalidResponse
    case invalidData
    case authenticationError
    case unknownError
    case decodingError(reason: String)
    
    var localizedDescription: String {
        switch self {
        case .unableToComplete:
            return "Unable to complete the request. Please check your internet connection."
        case .invalidResponse:
            return "Invalid response received from the server. Please try again later."
        case .invalidData:
            return "Invalid data received from the server. Please try again later."
        case .authenticationError:
            return "Authentication failed. Please check your credentials and try again."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        case .decodingError(let reason):
            return "Decoding error occurred: \(reason)"
        }
    }
}


// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func request<ResponseType: Codable>(_ endpoint: Endpoint, completion: @escaping(Result<ResponseType, NetworkError>) -> Void)
}

// MARK: - NetworkManager
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager: NetworkManagerProtocol {
    func request<ResponseType: Codable>(_ endpoint: Endpoint, completion: @escaping(Result<ResponseType, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            guard  error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(.success(decodedData))
            } catch let error{
                completion(.failure(.decodingError(reason: error.localizedDescription)))
            }
        }.resume()
    }
}
