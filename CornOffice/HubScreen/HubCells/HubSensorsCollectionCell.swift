//
//  HubCollectionTableCell.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit
import FirebaseAuth

class HubSensorsCollectionCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "HubCollectionTableCell"
    
    let source = DispatchSource.makeTimerSource()
    
    var sensorsList = [SensorModel]()
    var sensorManager = SensorManager()
    
    var userEmail: String = "no-info"
    
    // MARK: - UI
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    let sensorsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.register(SensorCollectionViewCell.self, forCellWithReuseIdentifier: SensorCollectionViewCell.identifier)
        collection.alwaysBounceVertical = false
        return collection
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sensorsCollection.dataSource = self
        sensorsCollection.delegate = self
        
        sensorManager.delegate = self
        sensorManager.fetchSensors(for: userEmail)
        
        startRepeatingUpdate()
        
        if let email = Auth.auth().currentUser?.email {
            userEmail = email
        } else {
            userEmail = "no-info"
        }
        
        backgroundColor = .clear
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { 
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupViews() {
        contentView.addSubview(sensorsCollection)
        contentView.addSubview(activityIndicator)
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
    }
    
    // MARK: - Functions
    
    func startRepeatingUpdate() {
        source.setEventHandler {
            self.sensorManager.fetchSensors(for: self.userEmail)
        }
        source.schedule(deadline: .now(), repeating: 2)
        source.activate()
    }
}

// MARK: - UICollectionViewDelegate

extension HubSensorsCollectionCell: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension HubSensorsCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sensorsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SensorCollectionViewCell.identifier, for: indexPath) as? SensorCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(sensor: sensorsList[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HubSensorsCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (sensorsCollection.frame.width - 10) / 2
        return CGSize(width: width, height: 140)
    }
}

// MARK: - SensorManagerDelegate

extension HubSensorsCollectionCell: SensorManagerDelegate {
    func didFetchSensors(_ sensorManager: SensorManager, sensors: [SensorModel]) {
        DispatchQueue.main.async {
            self.sensorsList = sensors
            self.activityIndicator.stopAnimating()
            self.sensorsCollection.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
