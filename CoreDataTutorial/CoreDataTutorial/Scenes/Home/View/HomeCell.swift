//
//  HomeCell.swift
//  CoreDataTutorial
//
//  Created by Baran Baran on 15.06.2024.
//

import UIKit
import CoreData

final class HomeCell: UITableViewCell {
    
    // MARK: Properties
    public static let reuseID: String = "HomeCell"
    public var model: UserResponse? {
        didSet {
            configure()
        }
    }
    
    
    
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var favoriteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = .systemYellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    public func configure() {
        guard let model = model else { return }
        nameLabel.text = model.name
    }
    
    // MARK: - Layout
    fileprivate func layout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            // Label constraints
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Button constraints
            favoriteButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Actions
    @objc fileprivate func favoriteButtonTapped() {
        print("Favorite button tapped")
        guard let model = model else { return }
        // Save Data
        let user = UserDatabase(context: CoreDataManager.shared.context)
        user.name = model.name
        print("Saved database")
        CoreDataManager.shared.save(user)
    }
}

// MARK: - Preview
#Preview {
    HomeBuilder.build()
}
