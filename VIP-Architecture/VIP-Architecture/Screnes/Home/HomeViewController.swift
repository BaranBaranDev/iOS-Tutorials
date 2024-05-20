//
//  HomeViewController.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import UIKit
import SnapKit


// VIP Mimarisi: View- Interactor - Presenter -> Tek yönlü bir mimaridir.
/*
- View (Görünüm): Kullanıcı arayüzünden ve kullanıcı etkileşimlerinden sorumludur.Presenter'dan gelen veriyi gösterir ve kullanıcı etkileşimlerini Presenter'a iletir.
- Interactor (Etkileşimci): İş mantığını ve veri işlemlerini yönetir. Veriyi alır, işler ve Presenter'a sunar.
- Presenter (Sunucu): View ve Interactor arasında bir köprü görevi görür. Interactor'dan gelen veriyi formatlar ve View'a iletir, ayrıca View'dan gelen kullanıcı etkileşimlerini Interactor'a iletir.
 
* View -> Interactor (Request) : Kullanıcı bir veri yükleme butonuna tıkladığında, View Interactor'a veriyi yüklemesi için bir istek gönderir.
 Not: Router, navigasyon işlemlerinden ve ekranlar arasında geçiş yapmaktan sorumlu olan bileşendir
 
* Interactor -> Presenter (Response): Interactor, veritabanından veriyi çeker ve bu veriyi Presenter'a gönderir.
 Not: Worker bileşenleri, genellikle belirli bir görevi gerçekleştirmek için Interactor tarafından kullanılır. NetworkWorker, CoreDataWorker ..
 
* Presenter -> View (ViewModel): Presenter, Interactor'dan aldığı veriyi kullanıcı arayüzünde gösterilecek hale getirir ve View'a bu veriyi gönderir.
 
 
*/



// DisplayLogic protokolü, ViewController'ın Presenter tarafından çağrılacak olan fonksiyonları tanımlar. Bu protokol, ViewController'ın belirli bir veri modelini (ViewModel) alarak kullanıcı arayüzünü güncellemesini sağlar. İşte bu protokolün kullanılmasının nedenleri:
protocol HomeDisplayLogic: AnyObject {
    func display(viewModel: HomeModels.Calculate.ViewModel)
}



final class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var textFieldOne: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a number"
        tf.backgroundColor = .white
        tf.textColor = .blue
        tf.keyboardType = .decimalPad
        return tf
        
    }()
    
    private lazy var textFieldTwo: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a number"
        tf.textColor = .blue
        tf.backgroundColor = .white
        tf.keyboardType = .decimalPad
        return tf
    }()
    
    
    private lazy var calculateButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Calculate", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(tappedCalculateButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Result"
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldOne,textFieldTwo,calculateButton,resultLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: - Dependencies
    // iletim olacağından lazım
    private let interactor : HomeBusinessLogic
    
    // tıklama olunca geçişler için de router lazım
    private let router: HomeRouterLogic
    
    init(interactor: HomeBusinessLogic, router: HomeRouterLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    
    // MARK: - Layout
    private func setup(){
        view.addSubview(stackView)
        view.backgroundColor = .black
    }
    
    private func layout(){
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}

// MARK: -  DisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func display(viewModel: HomeModels.Calculate.ViewModel) {
        textFieldOne.text = ""
        textFieldTwo.text = ""
        // viewModel da ki sonuçta sunulacak düzenlenmiş veriyi verdik
        resultLabel.text = viewModel.resultText

    }
    
    // MARK:  Actions
    @objc fileprivate func tappedCalculateButton(){
        // Etkileşim olacağından Interactora gönderilecek
        interactor.calculate(request: HomeModels.Calculate.Request(firstNumber: textFieldOne.text, secondNumber: textFieldTwo.text))
    }
    
}
