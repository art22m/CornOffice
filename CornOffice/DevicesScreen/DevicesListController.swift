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
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = devicesListView
        self.devicesListView.devicesListTable.delegate = self
        self.devicesListView.devicesListTable.dataSource = self
        self.devicesListView.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        self.navigationItem.title = "Devices"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.devicesListView.refreshControl.endRefreshing()
        }
//        self.devicesListView.refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate

extension DevicesListController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension DevicesListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BulbListCell.identifier, for: indexPath) as? BulbListCell else { return UITableViewCell() }
        
        cell.configure(v1: "Workspace A1", v2: "TP-Link Kasa KL130")
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
