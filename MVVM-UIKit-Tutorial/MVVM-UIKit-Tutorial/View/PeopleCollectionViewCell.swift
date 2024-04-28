//
//  PeopleCollectionViewCell.swift
//  MVVM
//
//  Created by Baran Baran on 27.04.2024.
//
/*
 -> cell'e modelden veri getireceksek dizi değil tekil oluştur. Collection yapısının olduğu vc de diziye gerekli atama yap.
*/
import UIKit

protocol PeopleCollectionViewCellDelegate: AnyObject{
    func subscribe()
}

final class PeopleCollectionViewCell: UICollectionViewCell {
     // MARK: - Properties
    
    private var vw : PersonView?
    
    var personResponse: PersonResponse? {
        didSet{
            vw?.set(
                name: "\(personResponse?.firstName ?? "") \(personResponse?.lastName ?? "")",
                email: String(personResponse?.email ?? "")
            )
        }
    }
    
    
    weak var delegate: PeopleCollectionViewCellDelegate?
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

private extension PeopleCollectionViewCell {
    func setupUI(){
        setupPersonView()
        configurePersonView()
        
        
    }
}

// MARK: - configure && Setup
private extension PeopleCollectionViewCell {
    func setupPersonView(){
        guard vw == nil else {return}
        vw = PersonView{ [weak self] in
            guard let self = self else {return}
            self.delegate?.subscribe()
        }
    }
    
    
    func configurePersonView(){
        contentView.addSubview(vw!)
        
        vw!.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8).isActive = true
        vw!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        vw!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
