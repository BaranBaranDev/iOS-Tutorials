/*
 
 -> Interactor: Uygulamanın Bussines Logic olarak adlandırdığımız kısmıdır. Burada UI işlemleri yapılmaz. (Fetch,Update vs) işlemler burada gerçekleşir.
 -> Interactor katmanında, business logic dediğimiz işlemleri yapılır. Servisle ile iletişimi, veri kaynaklarına erişim ve veri işleme işlemleri Interactor’da yapılır. (Cell’lere dolduracak verileri alma işlemi, SearchBar’da yapılacak arama işlemi için API’dan veri çekmeyi bu katmanda yaparız.)
 
 */

import Foundation





// Interactor protokolü: View'dan gelen istekleri alan protokol
protocol HomeInteractorInputProtocol: AnyObject {
    func fetchUser() // API'den veri çekme isteği
}


final class HomeInteractor {
    //MARK: Dependencies
    
    weak var presenter: HomeInteractorOutputs?
    private var service: ServiceManagerProtocol
    
    init(service: ServiceManagerProtocol) {
        self.service = service
    }
}



extension HomeInteractor: HomeInteractorInputProtocol {
    func fetchUser() {
        print(APIUrl.usersURL.rawValue)
        service.fetchData(url: APIUrl.usersURL.rawValue) { [weak self] (result: Result<[UserEntity], Error>) in // result türünü belirtik böylece completion da decode edilecek entity yazdık
            
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                print("Success: \(users)") // Debug için ekledik
                self.presenter?.onSuccessUsers(users)
            case .failure(let error):
                print("Error: \(error.localizedDescription)") // Debug için ekledik
                self.presenter?.onError(error)
            }
        }
    }
}
