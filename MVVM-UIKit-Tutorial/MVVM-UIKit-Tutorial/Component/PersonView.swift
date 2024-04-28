//
//  PersonView.swift
//  MVVM
//
//  Created by Baran Baran on 25.04.2024.
//

import UIKit
/*
 PersonView sınıfınızın init metodunu güncellediniz ve artık bir closure parametresi alıyor. Bu closure, subscribeButton tıklandığında çağrılacak işlevi belirtir. Bu, PersonView'i daha esnek hale getirir ve bu bileşeni kullanırken özel işlevler tanımlamak için daha fazla seçenek sunar.
 action adında bir closure depolamak için bir özellik eklediniz ve bunu subscribeButton tıklandığında çağırmak için kullandınız.
 @objc fileprivate func buttonTapped() fonksiyonunu, artık bu fonksiyon action closure'ını çağırıyor.
 */

// final ile class kalıtım almaz, farklı class da kalıtım veremezsin. Perfonmansa olumlu etkisi vardır.
final class PersonView: UIView {
    
    // MARK: - UI Elements
    // lazy var ile çağrılınca oluşturulur ui , perfonmansa olumlu etkisi vardır.
    
    private lazy var subscribeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Subscribe"
        config.buttonSize = UIButton.Configuration.Size.large
        config.baseBackgroundColor = .systemRed
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "DR iOS"
        lbl.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "dr.ios@apple.com"
        lbl.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // MARK: - İnitialization
    
    typealias ActionType = () -> () // özel type
    private var action : ActionType // closure ile buton tıklanmasına yön verebileceğiz
    
    init(action: @escaping ActionType) {
        self.action = action
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func set(name: String, email: String){
        nameLabel.text = name
        emailLabel.text = email
    }
}

// MARK: - Helper

// private ile ext içerisin de ki methodlarda private yazmadan private işaretleyebiliriz.
private extension PersonView {
    func setup(){
        configure()
        drawDesign()
    }
    
    private func drawDesign(){
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Actions
extension PersonView {
    // addTarget da self belirtiğimizden private yerine fileprivate kullanarak daha güvenli olması için aynı dosyada erişilebilir kalması sağlandı.
    @objc fileprivate func buttonTapped(){
        action()
    }
}


// MARK: - Configure
private extension PersonView {
    func configure(){
        configureNameLabel()
        configureEmailLabel()
        configureSubscribeButton()
    }
    
    func configureNameLabel(){
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])
    }
    
    func configureEmailLabel(){
        self.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
    
    func configureSubscribeButton(){
        self.addSubview(subscribeButton)
        NSLayoutConstraint.activate([
            subscribeButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            subscribeButton.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            subscribeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}


