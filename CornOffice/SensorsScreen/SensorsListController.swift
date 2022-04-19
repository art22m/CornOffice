//
//  SensorsViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class SensorsListController: UIViewController {
    let sensorsListView = SensorsListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view = sensorsListView
        self.navigationItem.title = "Sensors"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure collection
        sensorsListView.sensorsCollection.delegate = self
        sensorsListView.sensorsCollection.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension SensorsListController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SensorsListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SensorCollectionViewCell.identifier, for: indexPath) as? SensorCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(v1: "Kitchen", v2: "Temperature", v3: "21°C")
        return cell
    }
}

extension SensorsListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (sensorsListView.sensorsCollection.frame.width - 10) / 2
        return CGSize(width: width, height: 140)
    }
}
