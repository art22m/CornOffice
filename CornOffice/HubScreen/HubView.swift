//
//  HubView.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class HubView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImage()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sensors_screen")
        backgroundImage.contentMode = .scaleAspectFill
        insertSubview(backgroundImage, at: 0)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(devicesListTable)
        NSLayoutConstraint.activate([
            devicesListTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            devicesListTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            devicesListTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            devicesListTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        devicesListTable.addSubview(refreshControl)
    }
    
}
