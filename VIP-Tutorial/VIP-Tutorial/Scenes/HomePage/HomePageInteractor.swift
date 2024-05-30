//
//  HomePageInteractor.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.



import Foundation

// MARK: - HomePageBusinessLogic


// Network işlemleri gibi işlemlerin girdisi
protocol HomePageBusinessLogic {
    func fetchUser(request: HomePage.FetchUser.Request)
}

// Taşınacak veri varsa buraya
protocol HomePageDataStore {
    // diziler sayfalarda anlamını yitirdiğinden o ilgili yere doğruydan erişim şart bundan dolayı mesela tableview da [UserResponse] kulanılıyorsa bize cell de veya geçişlerde UserResponse gerekir böylece seçili olana direk verilerine de ulaşabiliriz
    
    var userModel: UserResponse? { get set }
    
}


// MARK: - HomePageInteractor
final class HomePageInteractor: HomePageDataStore {
    
    // Data store logic
    
    var userModel: UserResponse? // bunu viewda dolduracağız ayrıca router da da geçiş sağlayacağız buraya ulaşmamız lazım
    
    
    //MARK: Dependencies

    private let networkWorker: NetworkWorkerProtocol
    private let presenter: HomePagePresentationLogic
    
    // MARK:  İnitialization
    
    init(networkWorker: NetworkWorkerProtocol, presenter: HomePagePresentationLogic) {
        self.networkWorker = networkWorker
        self.presenter = presenter
    }
}


extension HomePageInteractor: HomePageBusinessLogic{
    func fetchUser(request: HomePage.FetchUser.Request) {
        networkWorker.getUsers {[weak self] result in
            guard let self = self else{ return }

            switch result{
            case .success(let userResponse):
                presenter.presentFetchUser(response: HomePage.FetchUser.Response(users: userResponse))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
