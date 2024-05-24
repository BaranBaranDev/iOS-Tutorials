//
//  HomePageWorker.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.


import UIKit




// MARK: - NetworkWorkerProtocol & APIUrl


enum APIUrl: String{
    case usersURL = "https://jsonplaceholder.typicode.com/users"
}



protocol NetworkWorkerProtocol{
    func getUsers(completion: @escaping(Result<[UserResponse], Error>) -> Void)
}


// MARK: - HomePageWorker
final class HomePageWorker{}


extension HomePageWorker: NetworkWorkerProtocol{
    func getUsers(completion: @escaping (Result<[UserResponse], Error>) -> Void) {
        ServiceManager.shared.fetchData(url: APIUrl.usersURL.rawValue, completion: completion)
    }   
}
