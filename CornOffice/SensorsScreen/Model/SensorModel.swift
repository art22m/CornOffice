//
//  SensorModel.swift
//  CornOffice
//
//  Created by Artem Murashko on 19.04.2022.
//

import Foundation

struct SensorModel: Decodable {
    let place: String
    let status: Bool
    let type: String
    let value: Double
}
