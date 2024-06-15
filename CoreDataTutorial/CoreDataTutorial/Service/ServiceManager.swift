//
//  ServiceManager.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//

import Foundation



protocol ServiceProtocol {
    func fetchData<T: Codable>(url: String, completion: @escaping(Result<T, Error>) -> Void)
}


final class ServiceManager {
    public static let shared = ServiceManager()
    private init() {}
}


extension ServiceManager: ServiceProtocol {
    func fetchData<T: Codable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { fatalError("Not Found URL")}
        
        Task { [weak self] in
            guard self != nil else { return }
            do {
                let (data,_) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(error))
            }
            
        }
              
    }
}
