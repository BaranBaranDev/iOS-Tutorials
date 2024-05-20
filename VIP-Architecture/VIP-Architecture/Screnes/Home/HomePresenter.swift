//
//  HomePresenter.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import Foundation

// Presenter'ın sorumluluklarını tanımlamak ve ViewController ile iletişim kurmasını sağlamak için bir protokol kullanırız. Bu protokol, Presenter'ın gerçekleştireceği işlemleri tanımlar.
protocol HomePresenterLogic{
    func present(response: HomeModels.Calculate.Response)
}


// Presenter, Interactor'dan gelen verileri alır, kullanıcı arayüzüne uygun hale getirir ve ViewController'a iletir.
final class HomePresenter{
    //MARK: Public Properties
    // iletebilmek için lazımdı ve gereksiz özellikler almamak için viewın logicini yani protocolüne uyarladık
    weak var controller : HomeDisplayLogic?
}


extension HomePresenter: HomePresenterLogic{
    func present(response: HomeModels.Calculate.Response) {
        let descriptionText : String = "Toplamda \(response.resultNumber) ediyor."
        //  descriptionText i view a iletebilmem lazım
        controller?.display(viewModel: HomeModels.Calculate.ViewModel(resultText: descriptionText))
    }
}
