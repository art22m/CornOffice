//
//  TabBarViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sensorsVC = UINavigationController(rootViewController: SensorsListController())
        sensorsVC.title = "Sensors"
        
        let entranceScannerVC = EntranceScannerController()
        entranceScannerVC.title = "Enter"
        
        let devicesVC = UINavigationController(rootViewController: DevicesListController())
        devicesVC.title = "Devices"
        
        
        let hubVC = UINavigationController(rootViewController: HubController())
        hubVC.title = "Hub"
        
        
        self.tabBar.backgroundColor = .systemGray6
        self.modalPresentationStyle = .fullScreen
        
        self.setViewControllers([sensorsVC, entranceScannerVC, devicesVC, hubVC], animated: false)
        self.setIcons()
    }
    
    private func setIcons() {
        guard let items = self.tabBar.items else { return }
        let icons = ["sensor.tag.radiowaves.forward", "qrcode.viewfinder", "dot.radiowaves.left.and.right", "house"]
        
        for (id, item) in items.enumerated() {
            item.image = UIImage(systemName: icons[id])
        }
    }
}
