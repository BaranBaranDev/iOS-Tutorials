//
//  DetailModels.swift
//  VIP-Architecture
//
//  Created by Baran Baran on 19.05.2024.
//


import UIKit

// Screne adı
enum Detail
{
  // MARK: Use cases
  
//Yapılacak işlem adı
  enum Something
  {
      // view dan interactora gönderilen bilgi
    struct Request
    {
    }
      // interactordan presentera gönderilen atanmış ya da sonuç değeri
    struct Response
    {
    }
      // son kontrollerin yapıldığı daha doğrusu presenterdan viewa gönderilmeye uygun işlemlerin  alanı
    struct ViewModel
    {
    }
  }
}
