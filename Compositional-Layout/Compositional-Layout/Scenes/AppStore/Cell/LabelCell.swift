//
//  LabelCell.swift
//  Compositional-Layout
//
//  Created by Baran Baran on 4.07.2024.
//


import UIKit

class LabelCell: UICollectionReusableView {
    static let reuseIdentifier = "header-reuse-identifier"
    
    public lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Label"
        lbl.textColor = .label
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
