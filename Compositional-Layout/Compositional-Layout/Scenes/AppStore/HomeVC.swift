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
        // CollectionView layout'unu oluştur
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // Section index'e göre layout oluştur
            switch sectionIndex {
            case 0:
                return HomeVC.createFeaturedSection()
            case 1:
                return HomeVC.createRegularSection()
            default:
                return nil
            }
        }
        
        // CollectionView'i oluştur ve layout'u ata
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        // CollectionView'in frame'ini ana view'in boyutlarına ayarla
        collectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup() {
        // CollectionView arka plan rengini ayarla
        collectionView.backgroundColor = .systemBackground
        
        // CollectionView'i ana view'e ekle
        view.addSubview(collectionView)
        
        // NavBar'ı yapılandır
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // CollectionView'i yapılandır
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.reuseID)
        collectionView.register(LabelCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelCell.reuseIdentifier)
        
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
        // Section index'e göre hücre oluştur
        switch section {
        case 0:
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
            // İlk bölüm için HeaderCell kullan
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as! HeaderCell
            return cell
        case 1:
            // İkinci bölüm için HeaderCell kullan ve arka plan rengini mavi yap
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as! HeaderCell
            cell.backgroundColor = .blue
            return cell
        default:
            fatalError("Error")
        }
    }
    
    // Supplementary view (header) ayarları
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // LabelCell'i header olarak kullan
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LabelCell.reuseIdentifier, for: indexPath) as! LabelCell
        cell.label.text = "Compositional Layout"
        return cell
    }
}

// MARK: - Create Section : -> NSCollectionLayoutSection
extension HomeVC {
    // Öne çıkan bölüm (featured section) oluştur
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
    
    // Normal bölüm (regular section) oluştur
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
     
        // Header eklemek için supplementary item oluştur
        let supplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            // Genişlik tamamı, yükseklik 50 birim
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
            // Supplementary view'in türü section header
            elementKind: UICollectionView.elementKindSectionHeader,
            // Header'ın hizalaması üst ve sol
            alignment: .topLeading
        )
        
        // Section'a supplementary item'ı ekle
        layoutSection.boundarySupplementaryItems = [supplementaryItem]

        return layoutSection
    }
}
