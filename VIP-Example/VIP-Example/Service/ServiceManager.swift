//
//  ServiceManager.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import Foundation

protocol ServiceManagerProtocol {
    func fetchData<T: Codable>(url: String, completion: @escaping(Result<T,Error>) -> Void)
}


final class ServiceManager{
    static let shared = ServiceManager()
    private init(){}
}


extension ServiceManager: ServiceManagerProtocol{
    func fetchData<T: Codable>(url: String, completion: @escaping(Result<T,Error>) -> Void){
        guard let url = URL(string: url) else {fatalError("URL Error")}
        
        Task{ [weak self] in
            guard self != nil else { return }
            do{
                let (data, _) = try await URLSession.shared.data(from: url)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedResponse = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            }catch {
                completion(.failure(error))
            }
        }
    }
}
