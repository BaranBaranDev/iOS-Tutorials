//
//  UserNetwork.swift
//  NetworkLayer
//
//  Created by Baran Baran on 3.04.2024.
//

import Foundation

// Burası ara katman olacak viewdan erişmeyeceğim networkManagera buradan erişeceğim
// User modelimize erişmek için burayı kullanacağız ara katman gibi düşün. Ulaşacağımız struct belli type belirttik [User], completion dönecek bize böylece decode edilmiş yani structta ki User'a ulaşacağız..  Fonks içinde NetworkManageri çağıralım EndPointi verdik,  Completion ekledik zaten onun completionu dönecek
// Böylece View da çağırmaktan kurtulduk



// MARK: - UserNetworkProtocol
protocol UserNetworkProtocol {
    func getUser(completion: @escaping(Result<[User], NetworkError>) -> Void)
}

// MARK: - UserNetwork
final class UserNetwork {
    static let shared = UserNetwork()
    private init() {}
}


extension UserNetwork: UserNetworkProtocol {
    func getUser(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        NetworkManager.shared.request(Endpoint.getUsers, completion: completion)
    }
    
 
}




