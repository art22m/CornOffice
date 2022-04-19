//
//  LoginView.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import UIKit

class LoginView: UIView {
    // MARK: - UI
    let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login Account"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .red
        label.text = "Invalid login or password!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.sizeToFit()
        label.textAlignment = .center
        
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your email"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.continue
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.default
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.done
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundImage()
        setupViews()
        setupConstraints()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginView.dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "login_screen")
        backgroundImage.contentMode = .scaleAspectFill
        insertSubview(backgroundImage, at: 0)
    }
    
    func setupViews() {
        addSubview(loginView)
        loginView.addSubview(loginLabel)
        loginView.addSubview(warningLabel)
        loginView.addSubview(emailTextField)
        loginView.addSubview(passwordTextField)
        loginView.addSubview(loginButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            loginView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            loginView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            loginView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            loginLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            loginLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10),
            loginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            warningLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 10),
            warningLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -10),
            warningLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            warningLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -15),
            emailTextField.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 25),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -15),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

extension LoginView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField) {
            case emailTextField:
                emailTextField.resignFirstResponder()
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                passwordTextField.resignFirstResponder()
            default:
                break
        }
        return true
    }
}
