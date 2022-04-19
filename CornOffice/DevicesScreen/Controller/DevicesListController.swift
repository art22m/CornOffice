//
//  DevicesListController.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class DevicesListController: UIViewController {
    // MARK: - Properties
    let devicesListView = DevicesListView()
    var selectedIndex: IndexPath = IndexPath(row: -1, section: 0)
    
    var deviceManager = DeviceManager()
    var devicesList = [DeviceModel]()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = devicesListView
        self.devicesListView.devicesListTable.delegate = self
        self.devicesListView.devicesListTable.dataSource = self
        self.devicesListView.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        self.deviceManager.delegate = self
        self.deviceManager.fetchDevices()
        
        self.navigationItem.title = "Devices"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        deviceManager.fetchDevices()
    }
}

// MARK: - UITableViewDelegate

extension DevicesListController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension DevicesListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BulbListCell.identifier, for: indexPath) as? BulbListCell else { return UITableViewCell() }
        
        cell.configure(with: devicesList[indexPath.row])
        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == selectedIndex ? 200 : 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (selectedIndex == indexPath) {
            selectedIndex = IndexPath(row: -1, section: 0)
        } else {
            selectedIndex = indexPath
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate

extension DevicesListController: DeviceManagerDelegate {
    func didFetchDevices(_ deviceManager: DeviceManager, devices: [DeviceModel]) {
        DispatchQueue.main.async {
            self.devicesList = devices
            self.devicesListView.activityIndicator.stopAnimating()
            self.devicesListView.refreshControl.endRefreshing()
            self.devicesListView.devicesListTable.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
