//
//  HomeCell.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//

import UIKit


final class HomeCell: UITableViewCell {
    
    // MARK:  Properties
    public static let reuseID: String = "HomeCell"
    
    public var user: UserResponse? {
        didSet {
            configureUI()
        }
    }
    
    
    // MARK: - UI
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
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
    
    
    // MARK: - Configure
    fileprivate func configureUI() {
        guard let user = user else { return }
        label.text = user.name
    }
    
    // MARK: - Layout
    fileprivate func layout() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}



