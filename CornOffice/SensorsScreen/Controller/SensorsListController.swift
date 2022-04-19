//
//  SensorsViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class SensorsListController: UIViewController {
    let sensorsListView = SensorsListView()
    let source = DispatchSource.makeTimerSource()
    var sensorsList = [SensorModel]()
    var sensorManager = SensorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = sensorsListView
        self.navigationItem.title = "Sensors"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.sensorManager.delegate = self
        self.sensorManager.fetchSensors()
        
        // Configure collection
        self.sensorsListView.sensorsCollection.delegate = self
        self.sensorsListView.sensorsCollection.dataSource = self
        self.sensorsListView.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        self.startRepeatingUpdate()
    }
    
    func startRepeatingUpdate() {
        source.setEventHandler {
            self.sensorManager.fetchSensors()
        }
        source.schedule(deadline: .now(), repeating: 10)
        source.activate()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        sensorManager.fetchSensors()
    }
}

// MARK: - UICollectionViewDelegate

extension SensorsListController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension SensorsListController: UICollectionViewDataSource {
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

extension SensorsListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (sensorsListView.sensorsCollection.frame.width - 10) / 2
        return CGSize(width: width, height: 140)
    }
}

// MARK: - SensorManagerDelegate

extension SensorsListController: SensorManagerDelegate {
    func didFetchSensors(_ sensorManager: SensorManager, sensors: [SensorModel]) {
        DispatchQueue.main.async {
            self.sensorsList = sensors
            self.sensorsListView.activityIndicator.stopAnimating()
            self.sensorsListView.refreshControl.endRefreshing()
            self.sensorsListView.sensorsCollection.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
