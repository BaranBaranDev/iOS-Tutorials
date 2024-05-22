//
//  HomeCell.swift
//  VIP-Example
//
//  Created by Baran Baran on 21.05.2024.
//

import UIKit

final class HomeCell: UITableViewCell {
    // MARK:  UI Elements
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Label"
        lbl.textColor = .label
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
    
    // MARK: - Helpers
    
    public var user: HomeModels.UserViewModel?{
        didSet{configure()}
    }
    
    private func configure() {
        guard let user = user else {
            label.text = "Not Data!"
            return
        }
        
        label.text = user.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    private func layout(){
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}
