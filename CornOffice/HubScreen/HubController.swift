//
//  HubViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import UIKit

class HubController: UIViewController {
    let hubView = HubView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = hubView
    }
}
