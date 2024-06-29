/*
 
 -> Interactor: Uygulamanın Bussines Logic olarak adlandırdığımız kısmıdır. Burada UI işlemleri yapılmaz. (Fetch,Update vs) işlemler burada gerçekleşir.
 -> Interactor katmanında, business logic dediğimiz işlemleri yapılır. Servisle ile iletişimi, veri kaynaklarına erişim ve veri işleme işlemleri Interactor’da yapılır. (Cell’lere dolduracak verileri alma işlemi, SearchBar’da yapılacak arama işlemi için API’dan veri çekmeyi bu katmanda yaparız.)
 
 */

import Foundation

// Servic veya Veri işlemleri
protocol HomeBusinessLogic: AnyObject {
    func fetchCall()
}

// Geçiş yaparkan gönderilecek veriler mesela ..
protocol HomeDataStore: AnyObject {
    
}




final class HomeInteractor: HomeDataStore {
    //MARK: Dependencies
    
    public var presenter: HomeInteractorOutputs?
   // private var networkManager: INetworkService
    
  //  init(networkManager: INetworkService) {
   //     self.networkManager = networkManager
   // }
}



extension HomeInteractor: HomeBusinessLogic {
    func fetchCall() {
        // Modelden data geldi diyelim
        presenter?.onSuccessSearch()
    }
}
