//
//  HomeWorker.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//

import UIKit



protocol HomeNetworkWorker {
    func fetchUsers(completion: @escaping(Result<[UserResponse], Error>) -> Void )
}


final class HomeWorker: HomeNetworkWorker {
    func fetchUsers(completion: @escaping(Result<[UserResponse], Error>) -> Void ) {
        ServiceManager.shared.fetchData(url: "https://jsonplaceholder.typicode.com/users", completion: completion)
    }
}
