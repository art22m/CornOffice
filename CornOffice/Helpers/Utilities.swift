//
//  Utilities.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textField: UITextField) {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.systemBlue.cgColor
        
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
}
