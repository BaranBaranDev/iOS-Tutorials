//
//  HomeModels.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//

import Foundation

// Farklı işlemler için gerekli olan veri yapısını (data models) tanımlamak için kullanılır. Bu modeller, VIP döngüsünde verinin nasıl taşındığını ve işlendiğini temsil eder. Bu modeller, talep (Request), yanıt (Response) ve görünüm modeli (ViewModel) olarak üçe ayrılır. Bu üç aşama, verinin kullanıcı girişinden işlenmiş sonuç olarak kullanıcı arayüzüne yansıtılmasına kadar olan süreci kapsar.


enum HomeModels {
    enum Calculate {
        
        // Kullanıcıdan veya başka bir kaynaktan gelen girdileri temsil eder.Interactor'a gönderilen verileri içerir.
        struct Request {
            // textfieldden gelen veriler diyyelim
            let firstNumber: String?
            let secondNumber: String?
        }
        
        // İşlenmiş verileri temsil eder.Interactor'dan Presenter'a gönderilen verileri içerir.
        struct Response {
            // result'a atanacak değer diyelim
            let resultNumber: Int
        }
        
        // Kullanıcı arayüzüne uygun hale getirilmiş verileri temsil eder.Presenter'dan ViewController'a gönderilen verileri içerir.
        struct ViewModel {
            let resultText: String
        }
    }
}
