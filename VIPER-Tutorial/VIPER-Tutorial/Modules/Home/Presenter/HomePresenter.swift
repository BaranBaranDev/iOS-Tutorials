/*
 
 -> Bu katman o geliştirmenin en önemli kısmı çünkü routere da o söyleyecek, interactor den gelenlere de o yön verecek sayfanın ihtiyacı olan her şeyi yapacak kısacası.
 
 */
import Foundation

final class HomePresenter {
    //MARK: Dependencies
    weak var view: HomeViewInputs?
    private var interactor: HomeInteractorInputProtocol
    
    // MARK:  Initialization
    init(interactor: HomeInteractorInputProtocol) {
       
        self.interactor = interactor
    }
}

// Ekranın yapacağı ana logicler
extension HomePresenter: HomeViewPresenterInput {
    func viewDidLoad() {
        print("Presenter")
        interactor.fetchUser()
    }
}

// BusinessLogic
extension HomePresenter: HomeInteractorOutputs {
    func onSuccessUsers(_ users: [UserEntity]) {
        view?.showItems(users)
    }
    
    func onError(_ error: Error) {
        view?.showError(error)
    }
}
