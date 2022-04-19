//
//  SensorsListView.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class SensorsListView: UIView {
    // MARK: - UI
    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        
        return control
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    let sensorsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.register(SensorCollectionViewCell.self, forCellWithReuseIdentifier: SensorCollectionViewCell.identifier)
        return collection
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImage()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sensors_screen")
        backgroundImage.contentMode = .scaleAspectFill
        insertSubview(backgroundImage, at: 0)
    }
    
    func setupViews() {
        addSubview(sensorsCollection)
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sensorsCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sensorsCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sensorsCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            sensorsCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        sensorsCollection.addSubview(refreshControl)
    }
}
