//
//  TextFieldValidator.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import Foundation
import UIKit

struct TextFieldValidator {
    func validate(_ textField: UITextField) -> String? {
        if (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Please, enter all fields!"
        }
        
        return nil
    }
}
