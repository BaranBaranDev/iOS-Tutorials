//
//  HomeWorker.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation


enum APIUrl: String{
    case usersURL = "https://jsonplaceholder.typicode.com/users"
}


// NetworkWorkerProtocol, NetworkWorker sınıfının implement edeceği metodu tanımlar
protocol NetworkWorkerProtocol{
    func getUsers(completion: @escaping(Result<[UserResponse], Error>) -> Void)
}


// NetworkWorker, API'den kullanıcı verilerini çeken sınıftır. MVVM de service altında generic manager ile decode edilecek veri tipi, endpoind yada url belirttiğin sınıftır. Bunu clean swift yani vip mimarisinde NetworkWorker olarak oluşturuyoruz. Kafan karışmasın :)
final class NetworkWorker: NetworkWorkerProtocol{
    
    func getUsers(completion: @escaping (Result<[UserResponse], Error>) -> Void) {
        ServiceManager.shared.fetchData(url: APIUrl.usersURL.rawValue, completion: completion)
    }
    
}

