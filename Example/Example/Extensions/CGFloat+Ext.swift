//
//  UIScrene+Ext.swift
//  Example
//
//  Created by Baran Baran on 28.04.2024.
//

import UIKit

// static ile ext içerisinde property tutabilsin
// MARK: - CGFloat Ext
extension CGFloat{
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
