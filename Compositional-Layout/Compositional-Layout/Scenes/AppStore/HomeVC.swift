//
//  HomeVC.swift
//  Compositional-Layout
//
//  Created by Baran Baran on 3.07.2024.
//

import UIKit

final class HomeVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        /*
         // Layout oluştur ve bölümü layout'a ekle
         let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
         return AppStoreVC.createFeaturedSection()
         }
         */
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
                
            case 0 :
                return HomeVC.createFeaturedSection()
                
            case 1 :
                return HomeVC.createRegularSection()
                
            default:
                return nil
            }
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)  // CollectionView oluştur ve layout'u ata
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds // viewDidLayoutSubviews yerine Auto Layout kullanmak daha iyi bir yöntem
    }
    
    // MARK: - Setup
    private func setup() {
        // CollectionView arka plan rengini ayarla
        collectionView.backgroundColor = .systemBackground
        
        // CollectionView'i alt view olarak ekle
        view.addSubview(collectionView)
        
        // NavBar yapılandır
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // CollectionView yapılandır
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.reuseID)
        
        // CollectionView'e Auto Layout ekle
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Bölüm sayısı
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Her bir bölümdeki hücre sayısı
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 3
            
        case 1:
            return 5
            
        default:
            return 0
        }
    }
    
    // Hücre ayarları
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as! HeaderCell
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as! HeaderCell
            cell.backgroundColor = .blue
            return cell
        default:
            fatalError("Error")
        }
    }
}


// MARK: - Create Section : -> NSCollectionLayoutSection
extension HomeVC {
    static func createFeaturedSection() -> NSCollectionLayoutSection? {
        // Item boyutunu tanımla
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8))
        // Item oluştur
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Hücreler arası boşluk tanımla
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Grup boyutunu tanımla
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300))
        // Grup oluştur ve item'ı gruba ekle
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Bölüm oluştur ve grubu bölüme ekle
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // Yatay kaydırmayı etkinleştir
        
        return section
    }
    
    
    
    static func createRegularSection() -> NSCollectionLayoutSection? {
        // Item boyutunu tanımla: Genişliği collection view'in yarısı, yüksekliği yüksekliğe eşit
        let layoutItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        // Item oluştur ve iç dolgu ayarlarını yap
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Grup boyutunu tanımla: Genişliği collection view'in tamamı, yüksekliği iki item'in toplam yüksekliği
            let layoutGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.5) // azaltıkça yakınlaşır, arttırdıkça uzaklaşır
   
            )
        
        // Grup oluştur ve item'ları gruba ekle
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        // Bölüm oluştur ve grubu bölüme ekle
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       
        // yana kaydırmaya onay ve animasyonu
        //  layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
      
        // NSCollectionLayoutBoundarySupplementaryItem, bir collection view'a başlık, altbilgi veya arka plan gibi ek görsel öğeler eklemek için kullanılır.
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            // Genişlik Tamamı, uzunluk 50 brm kadar
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
            elementKind: "Test Cell",
            alignment: .topLeading )
        
        layoutSection.boundarySupplementaryItems = [supplementaryItem]

        
        return layoutSection
    }
}
