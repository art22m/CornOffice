//
//  DeviceModel.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import Foundation

struct DeviceModel: Codable {
    let name: String
    let place: String
    let status: Bool
    let type: String
    let uid: String
    let value: Int
}
