//
//  HomeCell.swift
//  VIP-Tutorial
//
//  Created by Baran Baran on 23.05.2024.
//

import UIKit

final class HomeCell: UITableViewCell {
    
    // MARK:  UI Elements
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Label"
        lbl.textColor = .label
        lbl.font = UIFont.preferredFont(forTextStyle: .title3)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // MARK: - Properties
    static let reuseID: String = "HomeCell"
    
    
    // MARK: - İnitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text =  nil
    }
    
    // MARK: Configure

    public func configure(model: UserResponse){
        label.text = model.name
    }
    
}


// MARK: - Layout
private extension HomeCell{
    func layout(){
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
