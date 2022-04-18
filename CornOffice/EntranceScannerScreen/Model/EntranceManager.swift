//
//  EntranceManager.swift
//  CornOffice
//
//  Created by Artem Murashko on 18.04.2022.
//

import Foundation

protocol EntranceManagerDelegate {
    func didConnectSuccessfully(_ entranceManager: EntranceManager)
    func didFailWithError(error: Error)
}

struct EntranceManager {
    var delegate: EntranceManagerDelegate?
    
    func entranceRequest(with entranceModel: EntranceModel) {
        guard let url = URL(string: "") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let requestBody = try JSONEncoder().encode(entranceModel)
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch {
            self.delegate?.didFailWithError(error: error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            self.delegate?.didConnectSuccessfully(self)
        }
        
        task.resume()
    }
}
