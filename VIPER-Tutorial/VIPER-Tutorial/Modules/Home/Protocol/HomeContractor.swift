
// Bizim için kullanacağımız fonksiyonları planlayıp, kullanması gerekilen yerlere servis eden ara bir katman olarak düşünebiliriz. Birçok repo ve kod okuduktan sonra ihtiyaç olduğunu gördüm kullanmadan da yapılabilir ama parçalamak her zaman hoşuma gitmiştir.

/*
 
 -> Interactor bize diyor ki ben sana servis işlerini yapıcam ve sonuçlarını vereceğim geri kalan yönetim sende.
 -> Peki bu input output napıyor onlar da diyor ki; ya biz input protocolu olarak o sayfanın yapacağı iç işleri karşılayacağız tabiki output da hemen ekliyor biz de dışarıya karşı olabilecek durumları karşılıyor olacağız.
 
 */



import Foundation


protocol HomeInteractorOutputs: AnyObject {
    func onSuccessUsers(_ users: [UserEntity]) // Veri başarıyla çekildiğinde çağrılır
    func onError(_ error: Error)
}

protocol HomeViewInputs: AnyObject {
    func showItems(_ users: [UserEntity]) // Verileri gösterir
    func showError(_ error: Error) // Hata mesajını gösterir

}

protocol HomeViewPresenterInput: AnyObject {
    func viewDidLoad()
  
}
