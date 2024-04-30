//
//  HomeVM.swift
//  Example
//
//  Created by Baran Baran on 30.04.2024.
//
/*
-> userArray sadece HomeVM sınıfı içerisinde değiştirilebilir, ancak dışarıdan okunabilir. Yani, sınıfın dışından bu dizinin değeri okunabilir değiştirilemez.
*/



import Foundation


// MARK: - HomeVMOutput Protocol

protocol HomeVMOutput: AnyObject {
    func didFinish()
    func didError(error: Error)
}



// MARK: - HomeViewModel

final class HomeVM{
    
    private(set) var userArray : [Users] = []
    weak var output : HomeVMOutput?
    
}

// MARK: - fetchData HomeVM Ext
// Düz mantık ile
extension HomeVM{
    @MainActor
    func fetchData() {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                // UI'ı karıştırmadan aktarmamız lazım sonucu escaping  ya da protocolleri kullanarak yapabiliriz
                self.userArray = decodedResponse.data
                output?.didFinish() // colletionView reload etmek için
                
            } catch {
                output?.didError(error: error)
            }
        }
    }
}

extension HomeVM{
        func getUser() {
        UserNetwork.shared.getUser { [weak self] result in
            guard let self = self else{return}
            switch result{
                
            case .success(let userResponse):
                self.userArray = userResponse.data
                output?.didFinish()
            case .failure(let error):
                self.output?.didError(error: error)
            }
        }
        

    }
}
