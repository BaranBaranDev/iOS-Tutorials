//
//  UIView+Ext.swift
//  NetworkLayer
//
//  Created by Baran Baran on 8.04.2024.
//

import UIKit

// Koşullu protokoll
// İlk başta oluşturacağımız methodu belirt , extensions ile güçlendir
// where Self: UIView diyerek UIView type da olursa çalışacağını belirttik bu güzel bir kullanımdır.

protocol Subviewsable {
    func addSubviews(_ views: UIView...)
}

extension Subviewsable where Self: UIViewController {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
}
