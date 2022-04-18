//
//  ViewController.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    // MARK: - Properties
    let loginView = LoginView()
    let textFieldValidator = TextFieldValidator()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        self.view = loginView
        
        // Assign buttons and text fields
        loginView.warningLabel.isHidden = true
        loginView.loginButton.addTarget(self, action: #selector(self.loginTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        Utilities.styleTextField(loginView.emailTextField)
        Utilities.styleTextField(loginView.passwordTextField)
    }
    
    // MARK: - Handle events
    @objc func loginTapped(sender: UIButton) {
        let emailFieldError = textFieldValidator.validate(loginView.emailTextField)
        if let error = emailFieldError {
            loginView.warningLabel.text = error
            loginView.warningLabel.isHidden = false
            sender.shake()
            return
        }
        
        let registerFieldError = textFieldValidator.validate(loginView.passwordTextField)
        if let error = registerFieldError {
            loginView.warningLabel.text = error
            loginView.warningLabel.isHidden = false
            sender.shake()
            return
        }
        
        
        loginView.warningLabel.isHidden = true
        guard let email = loginView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let password = loginView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
                
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.loginView.warningLabel.text = error.localizedDescription
                self.loginView.warningLabel.isHidden = false
                sender.shake()
                return
            }
            
            sender.pulsate()
            self.loginView.warningLabel.isHidden = true
        }
    }
    
}

