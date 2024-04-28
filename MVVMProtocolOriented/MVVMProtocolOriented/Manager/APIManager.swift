//
//  APIManager.swift
//  MVVMProtocolOriented
//
//  Created by Baran Baran on 28.04.2024.
//

// Advance kullanımda protocoller, dependercy injection kullanımı daha sağlıklıdır.

import Foundation

// MARK: - UserServiceProtocol
protocol UserServiceProtocol {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}

// MARK: - APIManager
final class APIManager {

}

// MARK: - APIManager && UserServiceProtocol
extension APIManager: UserServiceProtocol{
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
      
      let url = URL(string: "https://reqres.in/api/users/1")!
      
      URLSession.shared.dataTask(with: url) { data, res, error in
        guard let data = data else { return }
        DispatchQueue.main.async {
          if let user = try? JSONDecoder().decode(UserResponse.self, from: data).data {
            completion(.success(user))
          } else {
            completion(.failure(NSError()))
          }
        }
      }.resume()
    }
}

