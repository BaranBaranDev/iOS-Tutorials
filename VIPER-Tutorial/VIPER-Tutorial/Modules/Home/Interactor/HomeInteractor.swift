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
    // MARK: Dependencies
    weak var presenter: HomeInteractorOutputs?
    private var service: ServiceManagerProtocol

    init(service: ServiceManagerProtocol) {
        self.service = service
    }
}

extension HomeInteractor: HomeInteractorInputProtocol {
    func fetchUser() {
        // API URL'sini kontrol etmek için basit bir debug mesajı
        print("Fetching users from URL: \(APIUrl.usersURL.rawValue)")
        
        // Veriyi çekmek için service çağrısı
        service.fetchData(url: APIUrl.usersURL.rawValue) { [weak self] (result: Result<[UserEntity], Error>) in
            // Weak self kontrolü
            guard let self = self else { return }
            
            // Result durumunu kontrol et
            switch result {
            case .success(let users):
                // Başarılı durum - kullanıcı verisi alındı
                print("Fetched users successfully: \(users)")
                self.presenter?.onSuccessUsers(users)
            case .failure(let error):
                // Hata durumu - hata mesajını yazdır
                print("Failed to fetch users: \(error.localizedDescription)")
                self.presenter?.onError(error)
            }
        }
    }
}
