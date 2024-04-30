//
//  HomeCell.swift
//  Example
//
//  Created by Baran Baran on 28.04.2024.
//

import UIKit

// MARK: - HomeCellDelegate Protocol
protocol HomeCellDelegate: AnyObject {
    func didTapCell(email: String)
}

// MARK: - HomeCell Class

final class HomeCell: UICollectionViewCell {

    // MARK: - UI Elements
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = " Label"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    
    // MARK: - Properties
    static let reuseID: String = "HomeCell"
    
    var user : Users?{
        
        didSet{
            reloadUI()
        }
    }
    
    weak var delegate: HomeCellDelegate?
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        gestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - reloadUI
    private func reloadUI(){
        guard let user = user else {return}
        label.text = user.firstName
        print(user.firstName)
    }
    
    private func gestureRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        contentView.addGestureRecognizer(gestureRecognizer)
    }
    // MARK: - Actions
    @objc fileprivate func tappedView(){
        guard let user = user else {return}
        print("\(user.email)")
 
        delegate?.didTapCell(email: user.email)
    }
    
}

// MARK: - Helpers
extension HomeCell {
    private func setupUI(){
        configure()
        drawDesign()
    }
    private func drawDesign(){
        contentView.backgroundColor = .tertiarySystemGroupedBackground
    }
}

// MARK: - Configure
private extension HomeCell{
    func configure(){
        configureSubviews()
        configureLabel()
    }
    func configureSubviews(){
        contentView.addSubview(label)
    }
    func configureLabel() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
