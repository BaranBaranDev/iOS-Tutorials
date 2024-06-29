//
//  HomeCell.swift
//  VIPER-Tutorial
//
//  Created by Baran Baran on 23.06.2024.
//

import UIKit

final class HomeCell: UITableViewCell {
    
    // MARK:  Properties
    static let reuseID: String   = "HomeCell"
    
    // MARK: - UI Elements
    
    private lazy var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "selam"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // MARK: - İnitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layout
    
    fileprivate func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

    }
    
    // MARK: - Configure
    public func configure(model: UserEntity?) {
        guard let model = model else { return }
        self.titleLabel.text = model.name

    }
}



