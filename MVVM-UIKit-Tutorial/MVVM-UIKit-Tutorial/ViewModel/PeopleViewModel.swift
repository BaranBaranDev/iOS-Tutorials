//
//  PeopleViewModel.swift
//  MVVM
//
//  Created by Baran Baran on 26.04.2024.
//

import Foundation

/*
-> Task yapısı kullanılarak asenkron bir şekilde çağrı yapıldığında, iş parçacığının bloke edilmesi önlenir ve kullanıcı arayüzü etkilenmez.
 Bu nedenlerle, Task yapısı kullanılarak asenkron işlemler gerçekleştirildiğinde genellikle daha iyi bir performans elde edilir.
-> guard let self = self else {return}: Bu, güçlü bir referans döngüsünü önlemek için self'in zayıf bir referansa dönüştürülmesini sağlar. Bu, sınıfın anlamını koruyarak hafıza sızıntılarını önler.
 -> let (data, response) = try await URLSession.shared.data(from: url) tupple da ilki data diğeri response döner response kullanmadım bundan dolayı _ 
 */


// haberleşme lazımsa delegeden protokol mevzuya hazır :)
protocol PeopleViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}


final class PeopleViewModel{
    
    private(set) var people : [PersonResponse] = []
    
    weak var delegate : PeopleViewModelDelegate?
    
}


extension PeopleViewModel{
    @MainActor // Kodun main thread de çalışmasını sağlar.
    func getUsers(){
        Task{ [weak self] in
            guard let self = self else {return}
            do{
                guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase // model de coding keys yazmaya gerek kalmaz
                
                let decodedUserResponse = try jsonDecoder.decode(UserResponse.self, from: data)
                self.people = decodedUserResponse.data
                delegate?.didFinish() 
                
            }catch {
                delegate?.didFail(error: error)
            }
        }
    }
}
