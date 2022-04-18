//
//  ViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class LoginController: UIViewController {
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        self.view = loginView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        Utilities.styleTextField(loginView.emailTextField)
        Utilities.styleTextField(loginView.passwordTextField)
    }

}

