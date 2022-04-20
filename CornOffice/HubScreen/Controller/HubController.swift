//
//  HubViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class HubController: UIViewController {
    // MARK: - Properties
    let hubView = HubView()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Your work space"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view = hubView
        self.hubView.hubTable.dataSource = self
        self.hubView.hubTable.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension HubController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension HubController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HubSensorsCollectionCell.identifier, for: indexPath) as? HubSensorsCollectionCell else { return UITableViewCell() }
            return cell
        } else if (indexPath.row == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HubDevicesTableCell.identifier, for: indexPath) as? HubDevicesTableCell else { return UITableViewCell() }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180
        } else if (indexPath.row == 1) {
            return 400
        }
        
        return 200
    }
}

