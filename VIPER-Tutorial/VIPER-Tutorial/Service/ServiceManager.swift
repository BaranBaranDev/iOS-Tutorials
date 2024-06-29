//
//  ServiceManager.swift
//  VIPER-Tutorial
//
//  Created by Baran Baran on 29.06.2024.
//

import Foundation


// MARK: - ServiceManagerProtocol Protocol

protocol ServiceManagerProtocol {
    func fetchData<T: Codable>(url urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - ServiceManager

final class ServiceManager {}

extension ServiceManager: ServiceManagerProtocol{
    func fetchData<T: Codable>(url: String, completion: @escaping(Result<T,Error>) -> Void){
        guard let url = URL(string: url) else { return }
        
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
