//
//  DetailVC.swift
//  Example
//
//  Created by Baran Baran on 28.04.2024.
//

import UIKit


final class DetailVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = " Your Email"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var selectedEmail: String?{
        didSet{
            reloadUI()
        }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    private func reloadUI(){
        label.text = selectedEmail
    }
    
}


// MARK: - Helpers

extension DetailVC {
    private func setupUI(){
        configure()
        drawDesign()
    }
    private func drawDesign(){
        view.backgroundColor = .systemCyan
    }
}

// MARK: - Configure
private extension DetailVC{
    func configure(){
        configureSubviews()
        configureLabel()
    }
    func configureSubviews(){
        view.addSubview(label)
    }
    func configureLabel() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}


