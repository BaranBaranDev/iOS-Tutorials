//
//  UserViewModel.swift
//  MVVMProtocolOriented
//
//  Created by Baran Baran on 28.04.2024.
//

import Foundation



/*

 - fetchUsers normal de vc de idi biz onu buraya taşıyoruz. Verileri çekiyor eylem var iş akışı view model da olur
 - Service yani api manager içerisine gelen metoda ulaşmam lazım. Yalnız burada da test edilebilir kod olması için Dependercy Injection kullanırız. Manager bulunduğu yerde de fonksu protocolle verdik. Bağımllığı azaltmak için type protocol olarak belirtebilirsin. Kullandığı class da doldurulan özellikleri de verir bize karşısına da manager class yazarsın böylece protocolleri değiştirerek farklı bir işin varsa halledersin. Yapı şu şekilde olmalı
     let userService : UserServiceProtocol = APIManager()
     let viewModel  = UserViewModel(service: userService)
     window?.rootViewController = UserViewController(viewModel: viewModel)
    Bu sayede manager ya da farklı bir classın protocole uyması gerekir daha güvenli bir yapıdır bu.
 
 - UserViewModelOutput adında protocol oluşturduk. Amacımız kullanıcı arasında sözleşme olması bunu delege yani haberleşme için kullanacağız. Buradaki çıktıları bununla vc ye taşıyacağız.
 - weak ile gelen referanslı zayıf tutarız bunu yapabilmek için de protocolün de sadece classlar tarafından kullanacağını garantiletmek ,ç,n AnyObject olarak işaretleriz
 - Nerede closure orada weak self böylece retain cycle önleriz [weak self] ve     guard let self = self else {return} kontrol sağlarız böylece optional olmaktan kurtarırız.
 - Ek bilgi nasıl iş akışı burada yönetiliyorsa aynı şekil ui burada değil vieew da olmalı haberleşmeyi de UserViewModelOutput sayesinde delege olarak belirterek burada alınan özellikler aktarılıyor
*/


protocol UserViewModelOutput: AnyObject {
    func uptadeView(imageURL: String, email: String)
}

final class UserViewModel{
    
    // Service Dependercy Injection
    private let userService: UserServiceProtocol
    init(service: UserServiceProtocol) {
        self.userService = service
    }
    
    //
    weak var output: UserViewModelOutput?
}




extension UserViewModel {
    func fetchUsers() {
        userService.fetchUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.output?.uptadeView(imageURL: user.avatar, email: user.email) // Başarılı kullanıcı verisi alındığında metodun doğrudan çağrılması
            case .failure:
                let errorImageUrl = "https://cdn.pixabay.com/photo/2015/06/09/16/12/error-803716_1280.png"
                self.output?.uptadeView(imageURL: errorImageUrl, email: "No user found") // Hata durumunda varsayılan
            }
        }
    }
}



