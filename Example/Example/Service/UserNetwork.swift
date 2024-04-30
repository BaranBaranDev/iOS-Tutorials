//
//  UserNetwork.swift
//  Example
//
//  Created by Baran Baran on 29.04.2024.
//

import Foundation



// MARK: - UserNetworkProtocol

protocol UserNetworkProtocol {
    func getUser(completion: @escaping(Result<UserResponse, NetworkError>) -> Void)
}

// MARK: - UserNetwork

final class UserNetwork: UserNetworkProtocol {
    static let shared = UserNetwork()
    private let networkManager: NetworkFetching // Dependency Injection

    // Dependency Injection yapılandırıcısı
    private init(networkManager: NetworkFetching = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    // Kullanıcı verilerini al
    func getUser(completion: @escaping (Result<UserResponse, NetworkError>) -> Void) {
        networkManager.fetchData(url: "https://reqres.in/api/users?page=2", completion: completion)
    }
}


