//
//  ViewController.swift
//  Layout
//
//  Created by Baran Baran on 18.05.2024.
//

import UIKit
import SnapKit


final class ViewController: UIViewController {
    private let aview = AView()
    private let bview = BView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [aview,bview])
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
    }
    
    // Eğer yapıyı tamamen kaplamak isteseydim buradan da yapabilirdim
    override func viewDidLayoutSubviews() {
   //     stackView.frame = view.bounds
    }
    // MARK: - Layout
    
    private func setup(){
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
    }
    
    private func layout(){
        
        // MARK: NSLayoutConstraint kullanımı
/*
        Ya böyle
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        /Ya da böyle
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
         
        ])
        
*/
        
        // MARK:  Snapkit kullanımı:
        
        // stackview e constraint atayalım
        stackView.snp.makeConstraints { make in
            // ayarlama yapacağım bileşen.snp.hizalayacağın kısmı
            make.leading.equalTo(view.snp.leading).offset(8) // solunu viewın solundan 8 point bırak
            make.trailing.equalTo(view.snp.trailingMargin).offset(-8) // sağını , Layout margin boşluklu yani biraz mesafe bırakılmış olarak düşün ona göre 8 lik bıraktık. Trailing ve Bottom da yapı atamalarda sağa ya da aşağıya gittiğinden normal de - li değer vererek içe doğru baskılarız. Eğer offset ile kullanıyorsan bunu yapabilirsin yalnız inset ile snapkit de - li yani negatif değer vermeden de direk yaapbilirsin mesela bunu altta bottom da gösterelim
            make.bottom.equalTo(view.snp.bottomMargin).inset(8) // offset kullansaydım - kullanmam lazımdı ya böyle yap yada top,leading offset kullan. Bottom, trailing de ise inset kullan
            make.top.equalTo(view.snp.topMargin).offset(8)
            
        }
        
    }


}




final class AView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // boyutlandırma yapabilirsin ya da snapkit veya normal atama ile de dışarıdan da bu viewa verebiliriz
    override var intrinsicContentSize: CGSize{
        return .init(width: 100, height: 100)
    }
   
}



final class BView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
   
    override var intrinsicContentSize: CGSize{
        return .init(width: 100, height: 100)
    }
   
}
