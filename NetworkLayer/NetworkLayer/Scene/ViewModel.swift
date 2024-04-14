// Ne yapacağımıze protokollerle karar verelim bunun için protokol oluşturalım
// Böylece direk erişimi engelleriz ve extensions kullanarak yetkilendiririz
// Temel methodları vc den aktaralım viewDidLoad, viewwillApear
// Bize view lazım fakat direk tanımlarsam istemediğim özelliklere sahip olacağım bundan dolayı view protokolde yetkilendirerek almaya çalışacağım

// viewDidLoad aldı view onu ilettik ama viewModelinde view a ihtiyacı var bunu da yetkilendirme sağladığımız ViewInterface yani view protokolünden türeteceğiz çünkü bu zaten View uygulandığından orada ki view a ulaşabiliriz. Yalnız iki tarafta olduğudnan strong referans olacak bunu weak diyerek zayıf işaretleyebiliriz böylece retain cycle önleriz ve aldığımız protokolü de AnyObject dememiz lazım çünkü class dan aldığımıza emin olmalıyız. İkisi arasında ki bind viewModel.view = self yani viewın benim diyerek sağlıyacağız View class da, buradaki view aslında delege gibi düşün  haberleşmeyi sağlıyor
// Olabildiğince vc de bulunan methodlara göre taşıyoruz..


import Foundation


protocol ViewModelInterface {
    var view : ViewController? {get set}
    func viewDidLoad()
    
    func numberOfRowsInSection() -> Int

    
}

final class ViewModel{
    weak var view: ViewController?
    
    var usersArray: [User] = []
    
    private func fetchData(){
        UserNetwork.shared.getUser { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.usersArray = users
                    self.view?.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension ViewModel:ViewModelInterface{


    func viewDidLoad() {
        view?.prepareTableView()
        fetchData()
        
    }
    
    func numberOfRowsInSection() -> Int {
        return usersArray.count

    }
    
 
 
    
    
}
