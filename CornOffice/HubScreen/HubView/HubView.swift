//
//  HubView.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class HubView: UIView {
    // MARK: - UI
    let hubTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        table.separatorStyle = .none
        table.register(HubSensorsCollectionCell.self, forCellReuseIdentifier: HubSensorsCollectionCell.identifier)
        table.register(HubDevicesTableCell.self, forCellReuseIdentifier: HubDevicesTableCell.identifier)
        
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
        addSubview(hubTable)
        NSLayoutConstraint.activate([
            hubTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            hubTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            hubTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            hubTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
