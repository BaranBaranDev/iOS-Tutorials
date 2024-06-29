/*
 
 -> Bu katman o geliştirmenin en önemli kısmı çünkü routere da o söyleyecek, interactor den gelenlere de o yön verecek sayfanın ihtiyacı olan her şeyi yapacak kısacası.
 
 */
import Foundation


final class HomePresenter {
    
    typealias HomeInteractorType = HomeBusinessLogic & HomeDataStore
    
     //MARK: Dependencies
    private var view: HomeViewInputs
    private var interactor: HomeInteractorType
    
    // MARK:  İnitialization
    
    init(view: HomeViewInputs, interactor: HomeInteractorType) {
        self.view = view
        self.interactor = interactor
    }
    
}


// Ekranın yapacağı ana logicler
extension HomePresenter: HomeViewPresenterInput {
    func viewDidLoad() {
        
    }
    
    func onTabCell() {
        
    }
    
    func fetchUser() {
        interactor.fetchCall()
        view.reloadTableView()
    }
    

    
}

// BusinessLogic
extension HomePresenter: HomeInteractorOutputs {
    func onSuccessSearch() {
        
    }
    
    func onErrorSearch() {
        
    }
    

    
}

