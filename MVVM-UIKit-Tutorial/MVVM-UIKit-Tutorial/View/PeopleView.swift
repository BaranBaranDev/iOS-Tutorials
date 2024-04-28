//
//  PeopleView.swift
//  MVVM
//
//  Created by Baran Baran on 26.04.2024.
//

import UIKit
import SafariServices


final class PeopleView: UIViewController {
    // MARK: - UI Elements
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let cv =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Properties
    
    let viewModel = PeopleViewModel()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.getUsers()
        viewModel.delegate = self
        
    }
}

// MARK: - UICollectionViewDataSource
extension PeopleView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let personItem = viewModel.people[indexPath.item] // dizi de ki değerlerin indeks numarasıyla atama sağlandı.
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PeopleCollectionViewCell
        cell.personResponse = personItem // hücreye aktarıldı
        cell.delegate = self // delege belirlendi haberleşme sağlanacak
        return cell
    }
}

// MARK: - PeopleViewModelDelegate
extension PeopleView: PeopleViewModelDelegate{
    func didFinish() {
        collectionView.reloadData()
    }
    
    func didFail(error: Error) {
        print(error)
    }
}

// MARK: - PeopleCollectionViewCellDelegate
extension PeopleView: PeopleCollectionViewCellDelegate{
    func subscribe() {
        if let url = URL(string: "https://www.youtube.com/@DRiOSDEV") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - Helper
private extension PeopleView {
    func setup(){
        configure()
       
    }
    
    
}


// MARK: - Configure
private extension PeopleView {
    func configure(){
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

