//
//  EntranceModel.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import Foundation

struct EntranceModel: Encodable {
    let key: Int
    let email: String
}

struct EntranceResponse: Decodable {
    let status: Int
    let key: Int
}
