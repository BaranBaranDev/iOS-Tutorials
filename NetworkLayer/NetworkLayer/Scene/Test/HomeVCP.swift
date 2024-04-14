//
//  HomeVC.swift
//  iOS-START
//
//  Created by Baran Baran on 3.04.2024.
//



/*

import UIKit

final class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    private func getUserData() {
        UserNetwork.shared.getUser { result in
            switch result {
            case .success(let users):
                // Başarılı durumda kullanıcı verilerini işle
                DispatchQueue.main.async {
                    // Kullanıcı verilerini işleme ve kullanıcı arayüzünü güncelleme işlemleri burada yapılır
                    self.updateUI(with: users)
                }
            case .failure(let error):
                // Hata durumunda kullanıcıya bilgi ver
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with users: [User]) {
        // Kullanıcı verilerini kullanıcı arayüzünde göstermek için uygun işlemleri burada gerçekleştir
        for user in users {
            print("Name: \(user.name), Email: \(user.email)")
        }
    }
}


*/
