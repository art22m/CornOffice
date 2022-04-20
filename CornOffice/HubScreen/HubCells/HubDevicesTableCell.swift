//
//  HubDevicesTableCell.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit
import FirebaseAuth

class HubDevicesTableCell: UITableViewCell {
    static let identifier = "HubDevicesTableCell"
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: 0)
    
    let source = DispatchSource.makeTimerSource()
    
    var deviceManager = DeviceManager()
    var devicesList = [DeviceModel]()
    
    var userEmail: String = "no-info"
    
    // MARK: - UI
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    let devicesListTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        table.register(BulbViewCell.self, forCellReuseIdentifier: BulbViewCell.identifier)
        table.register(KettleViewCell.self, forCellReuseIdentifier: KettleViewCell.identifier)
        
        return table
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        clipsToBounds = true
        
        devicesListTable.dataSource = self
        devicesListTable.delegate = self
        
        deviceManager.delegate = self
        deviceManager.fetchDevices(for: "s.v@mail.ru")
        
        startRepeatingUpdate()
        
        if let email = Auth.auth().currentUser?.email {
            userEmail = email
        } else {
            userEmail = "no-info"
        }
        
        backgroundColor = .clear

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(devicesListTable)
        NSLayoutConstraint.activate([
            devicesListTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            devicesListTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            devicesListTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            devicesListTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Functions
    func startRepeatingUpdate() {
        source.setEventHandler {
            self.deviceManager.fetchDevices(for: self.userEmail)
        }
        source.schedule(deadline: .now(), repeating: 3)
        source.activate()
    }
    
    @objc func switchBulb(_ sender: UISwitch) {
        deviceManager.switchBulb(id: devicesList[sender.tag].uid)
    }
    
    @objc func turnOnKettle(_ sender: UIButton) {
        sender.pulsate()
        deviceManager.turnOnKettle(id:devicesList[sender.tag].uid)
        print(devicesList[sender.tag].uid)
    }
}

// MARK: - UITableViewDelegate

extension HubDevicesTableCell: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension HubDevicesTableCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let device = devicesList[indexPath.row]

        switch device.type {
            case "kettle":
                guard let cell = tableView.dequeueReusableCell(withIdentifier: KettleViewCell.identifier, for: indexPath) as? KettleViewCell else { return UITableViewCell() }
                cell.configure(with: device)
                cell.turnOnButton.tag = indexPath.row
                cell.turnOnButton.addTarget(self, action: #selector(turnOnKettle(_:)), for: .touchUpInside)
                cell.animate()

                return cell
            case "bulb":
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BulbViewCell.identifier, for: indexPath) as? BulbViewCell else { return UITableViewCell() }
                cell.configure(with: device)
                cell.turnOnSwitch.tag = indexPath.row
                cell.turnOnSwitch.addTarget(self, action: #selector(switchBulb(_:)), for: .touchUpInside)
                cell.animate()

                return cell
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == selectedIndex ? 165 : 90
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

// MARK: - DeviceManagerDelegate

extension HubDevicesTableCell: DeviceManagerDelegate {
    func didUpdateDevice(_ deviceManager: DeviceManager) {
        deviceManager.fetchDevices(for: userEmail)
    }
    
    func didFetchDevices(_ deviceManager: DeviceManager, devices: [DeviceModel]) {
        DispatchQueue.main.async {
            self.devicesList = devices
            self.activityIndicator.stopAnimating()
            self.devicesListTable.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
