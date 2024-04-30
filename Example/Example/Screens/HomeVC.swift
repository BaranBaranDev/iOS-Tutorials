//
//  HomeVC.swift
//  Example
//
//  Created by Baran Baran on 28.04.2024.
//

import UIKit

final class HomeVC: UIViewController {
    
    // MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: .screenWidth, height: .screenHeight / 8)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    // MARK: - Properties
    
    private let viewModel : HomeVM
    
    // MARK: - LifeCycle
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
        viewModel.output = self
       // viewModel.fetchData()
        viewModel.getUser()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Helpers
private extension HomeVC {
    func setup(){
        configure()
        drawDesign()

    }
    
    func drawDesign(){
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
        collectionView.dataSource = self
    }
}

// MARK: - Configure
private extension HomeVC{
    func configure(){
        configureSubviews()
        configureCollectionView()
    }
    func configureSubviews(){
        view.addSubview(collectionView)
    }
    func configureCollectionView(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cell kontrol, dönüşüm olursa HomeCell eğer başarısız olursa boş göstersin.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.user = viewModel.userArray[indexPath.item] 
        cell.delegate = self // HomeCellDelegate
        return cell
    }
}


// MARK: - HomeVMOutput Protocol
extension HomeVC: HomeVMOutput {
    func didFinish() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didError(error: Error) {
        print(error.localizedDescription)
    }

}


// MARK: - Geçişler Push

extension HomeVC: HomeCellDelegate {
    func didTapCell(email: String) {
        let detailVC = DetailVC()
        detailVC.selectedEmail = email
        navigationController?.pushViewController(detailVC, animated: true)
    }
  
}
