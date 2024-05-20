//
//  HomeInteractor.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import Foundation

// Interactor'un hangi iş mantığını ve veri işlemlerini yöneteceğini belirleyen iki protokolümüz var: HomeBusinessLogic ve HomeDataStore.

// Bu protokol, Interactor'un iş mantığını tanımlar. Interactor'un gerçekleştireceği tüm işlemler burada belirtilir.
protocol HomeBusinessLogic: AnyObject {
    func calculate(request: HomeModels.Calculate.Request)
}

//Bu protokol, Interactor'un veri saklama gereksinimlerini tanımlar. İlgili verilerin depolanmasını sağlar.
protocol HomeDataStore {
    
}


//Interactor, kullanıcıdan gelen istekleri alır, gerekli işlemleri gerçekleştirir ve sonuçları Presenter'a gönderir.
final class HomeInteractor{
    
    //MARK: Dependencies
    // Interactor presentera gönderim yaapbilmek için presenter lazım ve worker ile de çalışmak için worker lazım. Temiz olması için protocollerine uyarla
    private let presenter: HomePresenterLogic
    private let worker: HomeWorker
    
    init(presenter: HomePresenterLogic, worker: HomeWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
}


extension HomeInteractor: HomeBusinessLogic,HomeDataStore{
    
    func calculate(request: HomeModels.Calculate.Request) {
        guard let firstNumber = Int(request.firstNumber ?? "") else{return}
        guard let secondNumber = Int(request.secondNumber ?? "") else{return}
        
        let result = firstNumber + secondNumber
        // result yani sonucu kullanıcının görebileceği şekilde düzenlenmesi için prenstera yolla
        presenter.present(response: HomeModels.Calculate.Response(resultNumber: result))
    }
    
}
