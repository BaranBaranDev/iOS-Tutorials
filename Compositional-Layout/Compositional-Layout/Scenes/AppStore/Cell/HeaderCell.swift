//
//  HeaderCell.swift
//  Compositional-Layout
//
//  Created by Baran Baran on 3.07.2024.
//

import UIKit


final class HeaderCell: UICollectionViewCell {
    
    static let reuseID: String = "HeaderCell"
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



